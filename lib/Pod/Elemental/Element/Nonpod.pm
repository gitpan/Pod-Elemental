package Pod::Elemental::Element::Nonpod;
our $VERSION = '0.002';

use Moose;
extends 'Pod::Elemental::Element';
# ABSTRACT: a non-pod element in a POD document

use Moose::Autobox;

has '+type' => (default => 'nonpod');

sub as_debug_string {
  # TODO: include first line or so of content -- rjbs, 2008-10-25
  return "(non-POD)\n";
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Nonpod - a non-pod element in a POD document

=head1 VERSION

version 0.002

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


