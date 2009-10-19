package Pod::Elemental::Transformer;
our $VERSION = '0.092920';


use Moose::Role;
use Moose::Autobox;
# ABSTRACT: something that transforms a node tree into a new tree

use namespace::autoclean;

requires 'transform_node';


1;

__END__

=pod

=head1 NAME

Pod::Elemental::Transformer - something that transforms a node tree into a new tree

=head1 VERSION

version 0.092920

=head1 METHODS

=head2 transform_node

  my $node = $nester->transform_node($node);

This method alters the given node and returns it.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


