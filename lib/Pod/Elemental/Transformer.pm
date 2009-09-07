package Pod::Elemental::Transformer;
our $VERSION = '0.092500';

use Moose::Role;
use Moose::Autobox;
# ABSTRACT: something that transforms a document tree into a new tree

use namespace::autoclean;

use Pod::Elemental::Element;
use Pod::Elemental::Element::Command;

requires 'transform_document';


1;

__END__

=pod

=head1 NAME

Pod::Elemental::Transformer - something that transforms a document tree into a new tree

=head1 VERSION

version 0.092500

=head1 METHODS

=head2 transform_document

  my $document = $nester->transform_document($document);

This method must produce a new Document based on the input Document.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


