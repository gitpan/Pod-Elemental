package Pod::Elemental::FormatRegion;
our $VERSION = '0.092901';


use Moose::Role;
with 'Pod::Elemental::Region';
# ABSTRACT: a region of Pod (this role likely to be removed)

use Moose::Autobox;

use Pod::Elemental::Types qw(FormatName);
use MooseX::Types::Moose qw(Bool);


has format_name => (is => 'ro', isa => FormatName, required => 1);


has is_pod => (is => 'ro', isa => Bool, required => 1, default => 1);

1;

__END__

=pod

=head1 NAME

Pod::Elemental::FormatRegion - a region of Pod (this role likely to be removed)

=head1 VERSION

version 0.092901

=head1 ATTRIBUTES

=head2 format_name

This is the format to which the document was targeted.  By default, this is
undefined and the document is vanilla pod.  If this is set, the document may or
may not be pod, and is intended for some other form of processor.  (See
L</is_pod>.)

=head2 is_pod

If true, this document contains pod paragraphs, as opposed to data paragraphs.
This will generally result from the document originating in a C<=begin> block
with a colon-prefixed target identifier:

  =begin :html

    This is still a verbatim paragraph.

  =end :html

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 

