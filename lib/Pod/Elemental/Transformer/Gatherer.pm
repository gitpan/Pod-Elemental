package Pod::Elemental::Transformer::Gatherer;
our $VERSION = '0.092920';


use Moose;
with 'Pod::Elemental::Transformer';
# ABSTRACT: gather related paragraphs under a shared header

use namespace::autoclean;

use Moose::Autobox 0.10;
use MooseX::Types::Moose qw(CodeRef);
use Pod::Elemental::Node;

# so here you'll specify something like:
#   find all =method paragraphs in the list and put them under a new node (like
#   =head1 METHODS) and put that in place of the first =method paragraph

has gather_selector => (
  is  => 'ro',
  isa => CodeRef,
  required => 1,
);

has container => (
  is   => 'ro',
  does => 'Pod::Elemental::Node',
  required => 1,
);

sub transform_node {
  my ($self, $node) = @_;

  my @indexes;
  for my $i (0 .. $node->children->length - 1) {
    push @indexes, $i if $self->gather_selector->($node->children->[ $i ]);
  }

  my @paras;
  for my $idx (reverse @indexes) {
    unshift @paras, splice @{ $node->children }, $idx, 1;
  }

  $self->container->children(\@paras);

  splice @{ $node->children }, $indexes[0], 0, $self->container;

  return $node;
}

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Transformer::Gatherer - gather related paragraphs under a shared header

=head1 VERSION

version 0.092920

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


