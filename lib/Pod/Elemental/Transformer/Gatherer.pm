package Pod::Elemental::Transformer::Gatherer;
{
  $Pod::Elemental::Transformer::Gatherer::VERSION = '0.102364';
}
use Moose;
with 'Pod::Elemental::Transformer';
# ABSTRACT: gather related paragraphs under a shared header

use namespace::autoclean;

use Moose::Autobox 0.10;
use MooseX::Types::Moose qw(CodeRef);
use Pod::Elemental::Node;


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

=encoding UTF-8

=head1 NAME

Pod::Elemental::Transformer::Gatherer - gather related paragraphs under a shared header

=head1 VERSION

version 0.102364

=head1 OVERVIEW

Like the Nester transformer, this Gatherer produces structure and containment
in a Pod document.  Unlike that Nester, it does not find top-level elements,
but instead produces them.

It looks for all elements matching the C<gather_selector>.  They are removed
from the node.  In the place of the first found element, the C<container> node
is placed into the transformed node, and all the gathered elements are made
children of the container.

So, given this document:

  Document
    =head1 Foo
    =over 4
    =item * xyzzy
    =item * abcdef
    =back
    =head1 Bar
    =over 4
    =item * 1234
    =item * 8765
    =back

...and this nester...

  my $gatherer = Pod::Elemental::Transformer::Gatherer->new({
    gather_selector => s_command( [ qw(over item back) ] ),
    container       => Pod::Elemental::Element::Pod5::Command->new({
      command => 'head1',
      content => "LISTS\n",
    }),
  });

Then this:

  $nester->transform_node($document);

Will result in this document:

  Document
    =head1 Foo
    =head1 LISTS
      =over 4
      =item * xyzzy
      =item * abcdef
      =back
      =over 4
      =item * 1234
      =item * 8765
      =back
    =head1 Bar

=head1 ATTRIBUTES

=head2 gather_selector

This is a coderef (a predicate) used to find the paragraphs to gather up.

=head2 container

This is a Pod::Elemental::Node that will be inserted into the node, containing
all gathered elements.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
