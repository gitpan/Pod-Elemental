package Pod::Elemental::Element::Text;
our $VERSION = '0.091470';

use Moose;
extends 'Pod::Elemental::Element';
# ABSTRACT: a POD text or verbatim element

use Moose::Autobox;

has '+type' => (default => 'text');

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Text - a POD text or verbatim element

=head1 VERSION

version 0.091470

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


