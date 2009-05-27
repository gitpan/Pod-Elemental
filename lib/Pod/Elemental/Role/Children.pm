package Pod::Elemental::Role::Children;
our $VERSION = '0.091470';

use Moose::Role;
# ABSTRACT: a thing with Pod::Elemental::Elements as children

use Moose::Autobox;


has children => (
  is   => 'rw',
  isa  => 'ArrayRef[Pod::Elemental::Element]',
  auto_deref => 1,
  required   => 1,
  default    => sub { [] },
);

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Role::Children - a thing with Pod::Elemental::Elements as children

=head1 VERSION

version 0.091470

=head1 ATTRIBUTES

=head2 children

This attribute is an arrayref of
L<Pod::Elemental::Element|Pod::Elemental::Element> objects, and represents
elements contained by an object.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


