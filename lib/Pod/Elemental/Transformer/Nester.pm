package Pod::Elemental::Transformer::Nester;
our $VERSION = '0.092940';


use Moose;
with 'Pod::Elemental::Transformer';
# ABSTRACT: group the document into sections


use Moose::Autobox 0.10;
use MooseX::Types::Moose qw(ArrayRef CodeRef);

use Pod::Elemental::Element::Nested;
use Pod::Elemental::Selectors -all;

use namespace::autoclean;


has top_selector => (
  is  => 'ro',
  isa => CodeRef,
  required => 1,
);


has content_selectors => (
  is  => 'ro',
  isa => ArrayRef[ CodeRef ],
  required => 1,
);

sub _is_containable {
  my ($self, $para) = @_;

  for my $sel ($self->content_selectors->flatten) {
    return 1 if $sel->($para);
  }

  return;
}

sub transform_node {
  my ($self, $node) = @_;

  # We use -2 because if we're already at the last element, we can't nest
  # anything -- there's nothing subsequent to the potential top-level element
  # to nest! -- rjbs, 2009-10-18
  PASS: for my $i (0 .. $node->children->length - 2) {
    last PASS if $i >= $node->children->length;

    my $para = $node->children->[ $i ];
    next unless $self->top_selector->($para);

    if (s_command(undef, $para) and not s_node($para)) {
      $para = $node->children->[ $i ] = Pod::Elemental::Element::Nested->new({
        command => $para->command,
        content => $para->content,
      });
    }

    if (! s_node($para) or $para->children->length) {
      confess "can't use $para as the top of a nesting";
    }

    my @to_nest;
    NEST: for my $j ($i+1 .. $node->children->length - 1) {
      last unless $self->_is_containable($node->children->[ $j ]);
      push @to_nest, $j;
    }

    if (@to_nest) {
      my @to_nest_elem = 
        splice @{ $node->children }, $to_nest[0], scalar(@to_nest);

      $para->children->push(@to_nest_elem);
      next PASS;
    }
  }

  return $node;
}

1;

__END__
=pod

=head1 NAME

Pod::Elemental::Transformer::Nester - group the document into sections

=head1 VERSION

version 0.092940

=head1 OVERVIEW

The Nester transformer is meant to find potential container elements and make
them into actual containers.  It works by being told what elements may be made
into containers and what subsequent elements they should allow to be stuffed
into them.

For example, given the following nester:

  use Pod::Elemental::Selectors qw(s_command s_flat);

  my $nester = Pod::Elemental::Transformer::Nester->new({
    top_selector      => s_command('head1'),
    content_selectors => [
      s_command([ qw(head2 head3 head4) ]),
      s_flat,
    ],
  });

..then when we apply the transformation:

  $nester->transform_node($document);

...the nester will find all C<=head1> elements in the top-level of the
document.  It will ensure that they are represented by objects that perform the
Pod::Elemental::Node role, and then it will move all subsequent elements
matching the C<content_selectors> into the container.

So, if we start with this input:

  =head1 Header
  =head2 Subheader
  Pod5::Ordinary <some content>
  =head1 New Header

The nester will convert its structure to look like this:

  =head1 Header
    =head2 Subheader
    Pod5::Ordinary <some content>
  =head1 New Header

Once an element is reached that does not pass the content selectors, the
nesting ceases until the next potential container.

=cut

=pod

=head1 ATTRIBUTES

=head2 top_selector

This attribute must be a coderef (presumably made from
Pod::Elemental::Selectors) that will test elements in the transformed node and
return true if the element is a potential new container.

=cut

=pod

=head2 content_selectors

This attribute must be an arrayref of coderefs (again presumably made from
Pod::Elemental::Selectors) that will test whether paragraphs subsequent to the
top-level container may be moved under the container.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

