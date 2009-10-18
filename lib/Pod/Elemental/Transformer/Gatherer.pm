package Pod::Elemental::Transformer::Gatherer;
our $VERSION = '0.092910';


use Moose;
with 'Pod::Elemental::Transformer';
# ABSTRACT: gather related paragraphs under a shared header

use namespace::autoclean;

# so here you'll specify something like:
#   find all =method paragraphs in the list and put them under a new node (like
#   =head1 METHODS) and put that in place of the first =method paragraph

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Transformer::Gatherer - gather related paragraphs under a shared header

=head1 VERSION

version 0.092910

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


