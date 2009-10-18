package Pod::Elemental::Element::Pod5::Verbatim;
our $VERSION = '0.092901';


use Moose;
extends 'Pod::Elemental::Element::Generic::Text';
with    'Pod::Elemental::Element::Pod5';
# ABSTRACT: a POD verbatim element

use namespace::autoclean;

sub as_debug_string {
  return '(Pod5 Verbatim)';
}

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Pod5::Verbatim - a POD verbatim element

=head1 VERSION

version 0.092901

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


