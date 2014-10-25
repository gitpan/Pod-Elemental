package Pod::Elemental::Node;
our $VERSION = '0.092920';


use Moose::Role;
# ABSTRACT: a thing with Pod::Elemental::Nodes as children

use namespace::autoclean;

use Moose::Autobox;
use MooseX::Types;
use MooseX::Types::Moose qw(ArrayRef);
use Moose::Util::TypeConstraints qw(class_type);

requires 'as_pod_string';
requires 'as_debug_string';


has children => (
  is   => 'rw',
  isa  => ArrayRef[ role_type('Pod::Elemental::Paragraph') ],
  required   => 1,
  default    => sub { [] },
);

around as_debug_string => sub {
  my ($orig, $self) = @_;

  my $str = $self->$orig;

  my @children = map { $_->as_debug_string } $self->children->flatten;
  s/^/  /sgm for @children;

  $str = join "\n", $str, @children;

  return $str;
};

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Node - a thing with Pod::Elemental::Nodes as children

=head1 VERSION

version 0.092920

=head1 ATTRIBUTES

=head2 children

This attribute is an arrayref of
L<Pod::Elemental::Node|Pod::Elemental::Node>-doing objects, and represents
elements contained by an object.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


