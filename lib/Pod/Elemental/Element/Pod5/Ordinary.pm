package Pod::Elemental::Element::Pod5::Ordinary;
our $VERSION = '0.093280';


use Moose;
extends 'Pod::Elemental::Element::Generic::Text';
with    'Pod::Elemental::Autoblank';
with    'Pod::Elemental::Autochomp';
# ABSTRACT: a Pod5 ordinary text paragraph


use namespace::autoclean;

1;

__END__
=pod

=head1 NAME

Pod::Elemental::Element::Pod5::Ordinary - a Pod5 ordinary text paragraph

=head1 VERSION

version 0.093280

=head1 OVERVIEW

A Pod5::Ordinary element represents a plain old paragraph of text found in a
Pod document that's gone through the Pod5 translator.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

