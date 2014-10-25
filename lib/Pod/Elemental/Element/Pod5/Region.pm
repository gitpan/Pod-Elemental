package Pod::Elemental::Element::Pod5::Region;
our $VERSION = '0.092900';


# ABSTRACT: a region of Pod (this role likely to be removed)
use Moose;
with qw(
  Pod::Elemental::Paragraph
  Pod::Elemental::Node
  Pod::Elemental::FormatRegion
  Pod::Elemental::Command
);

use Moose::Autobox;

sub command         { 'begin' }
sub closing_command { 'end' }

sub as_pod_string {
  my ($self) = @_;

  my $content = $self->content;

  my $colon = $self->is_pod ? ':' : '';

  if ($self->children->length) {
    my $string = sprintf "=%s %s%s\n",
      $self->command,
      $colon . $self->format_name,
      ($content =~ /\S/ ? " $content" : "\n");

    $string .= $self->children->map(sub { $_->as_pod_string })->join(q{});

    $string .= sprintf "\n=%s %s\n",
      $self->closing_command,
      $colon . $self->format_name;

    return $string;
  }

  return sprintf "=for %s%s",
    $colon . $self->format_name,
    ($content =~ /\S/ ? " $content" : "\n");
}

sub as_debug_string { $_[0]->as_pod_string }

no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Pod5::Region - a region of Pod (this role likely to be removed)

=head1 VERSION

version 0.092900

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


