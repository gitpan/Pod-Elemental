package Pod::Elemental;
our $VERSION = '0.092940';


use Moose;
# ABSTRACT: work with nestable Pod elements

use namespace::autoclean;

use Sub::Exporter::ForMethods ();
use Mixin::Linewise::Readers
  { installer => Sub::Exporter::ForMethods::method_installer },
  -readers;

use Moose::Autobox;
use MooseX::Types;

use Pod::Eventual::Simple;
use Pod::Elemental::Document;
use Pod::Elemental::Transformer::Pod5;
use Pod::Elemental::Objectifier;


sub read_handle {
  my ($self, $handle) = @_;
  $self = $self->new unless ref $self;

  my $events   = $self->event_reader->read_handle($handle);
  my $elements = $self->objectifier->objectify_events($events);

  my $document = $self->document_class->new({
    children => $elements,
  });

  return $document;
}


has event_reader => (
  is => 'ro',
  required => 1,
  default  => sub { return Pod::Eventual::Simple->new },
);


has objectifier => (
  is  => 'ro',
  isa => duck_type( [qw(objectify_events) ]),
  required => 1,
  default  => sub { return Pod::Elemental::Objectifier->new },
);


has document_class => (
  is       => 'ro',
  required => 1,
  default  => 'Pod::Elemental::Document',
);

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Pod::Elemental - work with nestable Pod elements

=head1 VERSION

version 0.092940

=head1 DESCRIPTION

Pod::Elemental is a system for treating a Pod (L<plain old
documentation|perlpod>) documents as trees of elements.  This model may be
familiar from many other document systems, especially the HTML DOM.
Pod::Elemental's document object model is much less sophisticated than the HTML
DOM, but still makes a lot of document transformations easy.

In general, you'll want to read in a Pod document and then perform a number of
prepackaged transformations on it.  The most common of these will be the L<Pod5
transformation|Pod::Elemental::Transformer::Pod5>, which assumes that the basic
meaning of Pod commands described in the Perl 5 documentation hold: C<=begin>,
C<=end>, and C<=for> commands mark regions of the document, leading whitespace
marks a verbatim paragraph, and so on.  The Pod5 transformer also eliminates
the need to track elements representing vertical whitespace.

=head1 SYNOPSIS

  use Pod::Elemental;
  use Pod::Elemental::Transformer::Pod5;

  my $document = Pod::Elemental->read_file('lib/Pod/Elemental.pm');

  Pod::Elemental::Transformer::Pod5->new->transform_node($document);

  print $document->as_debug_string, "\n"; # quick overview of doc structure

  print $document->as_pod_string, "\n";   # reproduce the document in Pod

=head1 METHODS

=head2 read_handle

=head2 read_file

=head2 read_string

These methods read the given input and return a Pod::Elemental::Document.

=cut

=pod

=head1 ATTRIBUTES

=head2 event_reader

The event reader (by default a new instance of
L<Pod::Eventual::Simple|Pod::Eventual::Simple> is used to convert input into an
event stream.  In general, it should provide C<read_*> methods that behave like
Pod::Eventual::Simple.

=cut

=pod

=head2 objectifier

The objectifier (by default a new Pod::Elemental::Objectifier) must provide an
C<objectify_events> method that converts Pod events into
Pod::Elemental::Element objects.

=cut

=pod

=head2 document_class

This is the class for documents created by reading pod.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

