package Pod::Elemental::Element;
our $VERSION = '0.003';

use Moose;
use Moose::Autobox;
# ABSTRACT: a POD element


has type       => (is => 'ro', isa => 'Str', required => 1);
has content    => (is => 'ro', isa => 'Str', required => 1);
has start_line => (is => 'ro', isa => 'Int', required => 0);


sub as_hash {
  my ($self) = @_;

  return {
    type    => $self->type,
    content => $self->content,
  };
}


sub as_string {
  my ($self) = @_;
  return $self->content . "\n";
}


sub as_debug_string {
  my ($self) = @_;
  return $self->as_string;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element - a POD element

=head1 VERSION

version 0.003

=head1 ATTRIBUTES

=head2 type

The type is a string giving a type for the element, like F<text> or F<nonpod>
or F<command>.  These are generally the same as the event types from the event
reader.

=head2 content

This is the textual content of the element, as in a Pod::Eventual event, but
has its trailing newline chomped.  In other words, this POD:

    =head2 content

has a content of "content"

=head2 start_line

This attribute, which may or may not be set, indicates the line in the source
document where the element began.

=head1 METHODS

=head2 as_hash

This returns a hashref describing the object.

=head2 as_string

This returns the element  as a string, suitable for turning elements back into
a document.  Some elements, like a C<=over> command, will stringify to include
extra content like a C<=back> command.  In the case of elements with children,
this method will include the stringified children as well.

=head2 as_debug_string

This method returns a string, like C<as_string>, but is meant for getting an
overview of the document structure, and is not suitable for reproducing a
document.  Its exact output is likely to change over time.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


