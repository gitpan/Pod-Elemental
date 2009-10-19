package Pod::Elemental;
our $VERSION = '0.092920';


use Moose;
use Moose::Autobox;
# ABSTRACT: work with nestable POD elements

use Mixin::Linewise::Readers -readers;

use Pod::Elemental::Document;
use Pod::Elemental::Transformer::Pod5;
use Pod::Elemental::Objectifier;
use Pod::Eventual::Simple;


has event_reader => (
  is => 'ro',
  required => 1,
  default  => sub { return Pod::Eventual::Simple->new },
);


has objectifier => (
  is => 'ro',
  required => 1,
  default  => sub { return Pod::Elemental::Objectifier->new },
);


has document_class => (
  is       => 'ro',
  required => 1,
  default  => 'Pod::Elemental::Document',
);


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

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental - work with nestable POD elements

=head1 VERSION

version 0.092920

=head1 ATTRIBUTES

=head2 event_reader

The event reader (by default a new instance of
L<Pod::Eventual::Simple|Pod::Eventual::Simple> is used to convert input into an
event stream.  In general, it should provide C<read_*> methods that behave like
Pod::Eventual::Simple.

=head2 objectifier

The objectifier (by default a new Pod::Elemental::Objectifier) must provide an
C<objectify_events> method that converts POD events into
Pod::Elemental::Element objects.

=head2 document_class

This is the class for documents created by reading pod.

=head1 METHODS

=head2 read_handle

=head2 read_file

=head2 read_string

These methods read the given input and return a Pod::Elemental::Document.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


