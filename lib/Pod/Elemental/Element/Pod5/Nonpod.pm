package Pod::Elemental::Element::Pod5::Nonpod;
our $VERSION = '0.092930';


use Moose;
with 'Pod::Elemental::Flat';
with 'Pod::Elemental::Autoblank';
# ABSTRACT: a non-pod element in a POD document

use namespace::autoclean;

sub as_pod_string {
  my ($self) = @_;
  return sprintf "=cut\n%s=pod\n", $self->content;
}

1;

__END__
=pod

=head1 NAME

Pod::Elemental::Element::Pod5::Nonpod - a non-pod element in a POD document

=head1 VERSION

version 0.092930

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

