package Pod::Elemental::Element::Pod5::Command;
our $VERSION = '0.092920';


use Moose;
# ABSTRACT: a Pod5 =command element

extends 'Pod::Elemental::Element::Generic::Command';
with    'Pod::Elemental::Autoblank';

use namespace::autoclean;

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Pod5::Command - a Pod5 =command element

=head1 VERSION

version 0.092920

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


