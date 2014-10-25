package Pod::Elemental::Transformer::Pod5;
our $VERSION = '0.092920';


use Moose;
with 'Pod::Elemental::Transformer';
# ABSTRACT: the default, minimal semantics of Perl5's pod element hierarchy

use Moose::Autobox 0.10;

use namespace::autoclean;

use Pod::Elemental::Document;
use Pod::Elemental::Element::Pod5::Command;
use Pod::Elemental::Element::Pod5::Data;
use Pod::Elemental::Element::Pod5::Ordinary;
use Pod::Elemental::Element::Pod5::Verbatim;
use Pod::Elemental::Element::Pod5::Region;

use Pod::Elemental::Selectors -all;

# TODO: handle the stupid verbatim-correction when inside non-colon-begin

sub _gen_class { "Pod::Elemental::Element::Generic::$_[1]" }
sub _class     { "Pod::Elemental::Element::Pod5::$_[1]" }

sub _region_para_parts {
  my ($self, $para) = @_;

  my ($colon, $target, $content, $nl) = $para->content =~ m/
    \A
    (:)?
    (\S+)
    (?:\s+(.+))?
    (\s+)\z
  /x;

  confess("=begin cannot be parsed") unless defined $target;

  $colon   ||= '';
  $content ||= '';

  return ($colon, $target, "$content$nl");
}

sub __extract_region {
  my ($self, $name, $in_paras) = @_;

  my %nest = ($name => 1);
  my @region_paras;

  REGION_PARA: while (my $region_para = shift @$in_paras) {
    if (s_command([ qw(begin end) ], $region_para)) {
      my ($r_colon, $r_target) = $self->_region_para_parts($region_para);

      for ($nest{ "$r_colon$r_target" }) {
        $_ += $region_para->command eq 'begin' ? 1 : -1;

        confess("=end $r_colon$r_target without matching begin") if $_ < 0;

        last REGION_PARA if !$_ and "$r_colon$r_target" eq $name;
      }
    }

    @region_paras->push($region_para);
  };

  return \@region_paras;
}

sub _collect_regions {
  my ($self, $in_paras) = @_;

  my @in_paras  = @$in_paras; # copy so we do not muck with input doc
  my @out_paras;

  my $s_region = s_command([ qw(begin for) ]);
  my $region_class = $self->_class('Region');

  PARA: while (my $para = shift @in_paras) {
    @out_paras->push($para), next PARA unless $s_region->($para);

    if ($para->command eq 'for') {
      my ($colon, $target, $content) = $self->_region_para_parts($para);

      my $region = $region_class->new({
        children    => [
          $self->_gen_class('Text')->new({ content => $content }),
        ],
        format_name => $target,
        is_pod      => $colon ? 1 : 0,
        content     => "\n",
      });

      @out_paras->push($region);
      next PARA;
    }

    my ($colon, $target, $content) = $self->_region_para_parts($para);

    my $region_paras = $self->__extract_region("$colon$target", \@in_paras);

    $region_paras->shift while s_blank($region_paras->[0]);
    $region_paras->pop   while s_blank($region_paras->[-1]);

    my $region = $region_class->new({
      children    => $self->_collect_regions($region_paras),
      format_name => $target,
      is_pod      => $colon ? 1 : 0,
      content     => $content,
    });

    @out_paras->push($region);
  }

  return \@out_paras;
}

sub _strip_ends {
  my ($self, $in_paras) = @_;

  my @in_paras  = @$in_paras; # copy so we do not muck with input doc

  @in_paras->shift while s_command('pod', $in_paras[0]);
  @in_paras->shift while s_blank($in_paras[0]);

  @in_paras->pop   while s_command('cut', $in_paras[-1]);

  return \@in_paras;
}

sub _autotype_paras {
  my ($self, $paras, $is_pod) = @_;

  $paras->each(sub {
    my ($i, $elem) = @_;
    
    if ($elem->isa( $self->_gen_class('Text') )) {
      my $class = $is_pod
                ? $elem->content =~ /\A\s/
                  ? $self->_class('Verbatim')
                  : $self->_class('Ordinary')
                : $self->_class('Data');

      $paras->[ $i ] = $class->new({ content => $elem->content });
    }

    if ($elem->isa( $self->_class('Region') )) {
      $self->_autotype_paras( $elem->children, $elem->is_pod );
    }

    if ($elem->isa( $self->_gen_class('Command') )) {
      $paras->[ $i ] = $self->_class('Command')->new({
        command => $elem->command,
        content => $elem->content,
      });
    }
  });

  # I really don't feel bad about rewriting in place by the time we get here.
  # These are private methods, and I know the consequence of calling them.
  # Nobody else should be.  So there.  -- rjbs, 2009-10-17
  return $paras;
}

sub __text_class {
  my ($self, $para) = @_;

  for my $type (qw(Ordinary Verbatim Data)) {
    my $class = $self->_class($type);
    return $class if $para->isa($class);
  }

  return;
}

sub _collect_runs {
  my ($self, $paras) = @_;

  $paras->grep(sub { $_->isa( $self->_class('Region') ) })->each_value(sub {
    $self->_collect_runs($_->children) 
  });

  PASS: for my $start (0 .. $#$paras) {
    last PASS if $#$paras - $start < 2; # we need X..Blank..X at minimum

    my $class = $self->__text_class( $paras->[ $start ] );
    next PASS unless $class;

    my @to_collect = ($start);
    NEXT: for my $next ($start+1 .. $#$paras) {
      if (
        $paras->[ $next ]->isa($class)
        or
        s_blank($paras->[ $next ])
      ) {
        push @to_collect, $next;
        next NEXT;
      }
      
      last NEXT;
    }

    pop @to_collect while s_blank($paras->[ $to_collect[ -1 ] ]);

    next PASS unless @to_collect >= 3;

    my $new_content = $paras
                    ->slice(\@to_collect)
                    ->map(sub { $_->content })
                    ->join(q{});

    splice @$paras, $start, scalar(@to_collect), $class->new({
      content => $new_content,
    });

    redo PASS;
  }

  @$paras = grep { not s_blank($_) } @$paras;

  # I really don't feel bad about rewriting in place by the time we get here.
  # These are private methods, and I know the consequence of calling them.
  # Nobody else should be.  So there.  -- rjbs, 2009-10-17
  return $paras;
}

sub transform_node {
  my ($self, $node) = @_;

  my $end_stripped     = $self->_strip_ends($node->children);
  my $region_collected = $self->_collect_regions($end_stripped);
  my $text_typed       = $self->_autotype_paras($region_collected, 1);
  my $text_collected   = $self->_collect_runs($text_typed);

  $node->children( $text_collected );

  return $node;
}

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Transformer::Pod5 - the default, minimal semantics of Perl5's pod element hierarchy

=head1 VERSION

version 0.092920

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


