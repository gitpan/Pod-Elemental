package Pod::Elemental::Flat;
our $VERSION = '0.092910';


use Moose::Role;
# ABSTRACT: a content-only pod paragraph

use namespace::autoclean;

with 'Pod::Elemental::Paragraph';
excludes 'Pod::Elemental::Node';

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Flat - a content-only pod paragraph

=head1 VERSION

version 0.092910

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


