package Pod::Elemental::Element::Pod5;
our $VERSION = '0.092901';


use namespace::autoclean;
use Moose::Role;
# ABSTRACT: a paragraph in a Pod document

override as_pod_string => sub {
  my $str = super;
  "$str\n";
};

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Pod5 - a paragraph in a Pod document

=head1 VERSION

version 0.092901

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


