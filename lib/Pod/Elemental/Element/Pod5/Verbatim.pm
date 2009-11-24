package Pod::Elemental::Element::Pod5::Verbatim;
our $VERSION = '0.093280';


use Moose;
extends 'Pod::Elemental::Element::Generic::Text';
with    'Pod::Elemental::Autoblank';
with    'Pod::Elemental::Autochomp';
# ABSTRACT: a Pod verbatim paragraph


use namespace::autoclean;

1;

__END__
=pod

=head1 NAME

Pod::Elemental::Element::Pod5::Verbatim - a Pod verbatim paragraph

=head1 VERSION

version 0.093280

=head1 OVERVIEW

Pod5::Verbatim elements represent "verbatim" paragraphs of text.  These are
ordinary, flat paragraphs of text that were indented in the source Pod to
indicate that they should be represented verbatim in formatted output.  The
following paragraph is a verbatim paragraph:

  This is a verbatim
      paragraph
         right here.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

