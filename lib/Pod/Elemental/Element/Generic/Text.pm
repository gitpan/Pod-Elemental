package Pod::Elemental::Element::Generic::Text;
our $VERSION = '0.092920';


use Moose;
with 'Pod::Elemental::Flat';
# ABSTRACT: a POD text or verbatim element

use namespace::autoclean;

sub as_debug_string {
  return '(Generic Text)';
}

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Generic::Text - a POD text or verbatim element

=head1 VERSION

version 0.092920

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


