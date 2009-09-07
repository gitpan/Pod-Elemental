package Pod::Elemental::Region;
our $VERSION = '0.092500';

use Moose::Role;
with qw(
  Pod::Elemental::Paragraph
  Pod::Elemental::Node
);
# ABSTRACT: a command that establishes a region

use Pod::Elemental::Types qw(FormatName);
use MooseX::Types::Moose qw(Bool);

requires 'closing_command';

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Region - a command that establishes a region

=head1 VERSION

version 0.092500

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


