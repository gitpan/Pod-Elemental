use strict;
use warnings;
package Pod::Elemental::Types;
our $VERSION = '0.092940';


# ABSTRACT: data types for Pod::Elemental
use MooseX::Types -declare => [ qw(FormatName) ];
use MooseX::Types::Moose qw(Str);


# Probably needs refining -- rjbs, 2009-05-26
subtype FormatName, as Str, where { length $_ and /\A\S+\z/ };

1;

__END__
=pod

=head1 NAME

Pod::Elemental::Types - data types for Pod::Elemental

=head1 VERSION

version 0.092940

=head1 OVERVIEW

This is a library of MooseX::Types types used by Pod::Elemental.

=head1 TYPES

=head2 FormatName

This is a valid name for a format (a Pod5::Region).  It does not expect the
leading colon for pod-like regions.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

