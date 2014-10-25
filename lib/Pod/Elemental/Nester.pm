package Pod::Elemental::Nester;
our $VERSION = '0.001';

use Moose;
use Moose::Autobox;
# ABSTRACT: it organizes a sequence of elements into a tree

use Pod::Elemental::Element;
use Pod::Elemental::Element::Command;

my %RANK = do {
  my $i = 0;
  map { $_ => $i++ } qw(head1 head2 head3 head4 over item begin for);
};

sub can_recurse {
  my ($self, $element) = @_;
  return 1 if $element->command eq [ qw(over begin) ]->any;
  return 0;
}

sub rank_for {
  my ($self, $element) = @_;
  return $RANK{ $element->command };
}

sub nest_elements {
  my ($self, $elements) = @_;

  my $top = Pod::Elemental::Element::Command->new({
    type     => 'command',
    command  => 'pod',
    content  => "\n",
  });

  my @stack  = $top;

  EVENT: while (my $element = $elements->shift) {
    Carp::croak("can't nest nonpod element") if $element->type eq 'nonpod';

    # =cut?  Where we're going, we don't need =cut. -- rjbs, 2015-11-05
    next if $element->type eq 'command' and $element->command eq 'cut';

    if ($element->type ne 'command') {
      $stack[-1]->children->push($element);
      next EVENT;
    }

    if ($element->command eq 'begin') {
      # =begin/=end are treated like subdocuments; we're going to look ahead
      # for the balancing =end, then pass the whole set of elements to a new
      # nestification process -- rjbs, 2008-10-20
      my $level  = 1;
      my @subdoc;

      SUBEV: while ($level and my $next = $elements->shift) {
        if (
          $next->type eq 'command'
          and $next->command eq 'begin'
          and $next->content eq $element->content
        ) {
          $level++;
          push @subdoc, $next;
          next SUBEV;
        }

        if (
          $next->type eq 'command'
          and $next->command eq 'end'
          and $next->content eq $element->content
        ) {
          $level--;
          push @subdoc, $next if $level;
          next SUBEV;
        }

        push @subdoc, $next;
      }

      $element->children->push( $self->nest_elements(\@subdoc)->flatten );
      $stack[-1]->children->push( $element );
      next EVENT;
    }

    if ($element->command eq 'back') {
      pop @stack until !@stack or $stack[-1]->command eq 'over';
      Carp::croak sprintf "found =back without =over at line %s",
        $element->start_line
        unless @stack;
      pop @stack; # we want to be outside of the 
      next EVENT;
    }

    if ($element->command eq 'end') {
      Carp::croak sprintf "found =end outside matching =begin at line %s",
        $element->start_line;
    }

    pop @stack until @stack == 1 or defined $self->rank_for($stack[-1]);

    my $rank        = $self->rank_for($element);
    my $parent_rank = $self->rank_for($stack[-1]) || 0;

    if (@stack > 1) {
      if (! $rank) {
        @stack = $top;
      } else {
        until (@stack == 1) {
          last if $self->rank_for($stack[-1]) < $rank;
          last if $self->can_recurse($element)
              and $element->command eq $stack[-1]->command;

          pop @stack;
        }
      }
    }

    $stack[-1]->children->push($element);
    @stack->push($element);
  }

  @$elements = $top->children->flatten;
  return $elements;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Nester - it organizes a sequence of elements into a tree

=head1 VERSION

version 0.001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


