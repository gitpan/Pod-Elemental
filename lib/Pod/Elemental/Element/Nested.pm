package Pod::Elemental::Element::Nested;
our $VERSION = '0.092920';


use Moose;
extends 'Pod::Elemental::Element::Generic::Command';
with 'Pod::Elemental::Node';
# ABSTRACT: an element that is a command and a node

use Moose::Autobox 0.10;

override as_pod_string => sub {
  my ($self) = @_;

  my $string = super;

  join q{},
    "$string\n",
    $self->children->map(sub { $_->as_pod_string })->flatten;
};

use namespace::autoclean;

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Nested - an element that is a command and a node

=head1 VERSION

version 0.092920

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


