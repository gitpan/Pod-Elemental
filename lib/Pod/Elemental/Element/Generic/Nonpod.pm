package Pod::Elemental::Element::Generic::Nonpod;
our $VERSION = '0.092901';


use Moose;
with 'Pod::Elemental::Paragraph';
# ABSTRACT: a non-pod element in a POD document

use namespace::autoclean;

sub as_debug_string { '??' }

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Generic::Nonpod - a non-pod element in a POD document

=head1 VERSION

version 0.092901

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


