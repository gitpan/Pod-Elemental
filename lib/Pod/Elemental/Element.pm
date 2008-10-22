package Pod::Elemental::Element;
our $VERSION = '0.001';

use Moose;
use Moose::Autobox;
# ABSTRACT: a POD element

has type       => (is => 'ro', isa => 'Str', required => 1);
has content    => (is => 'ro', isa => 'Str', required => 1);
has command    => (is => 'ro', isa => 'Str', required => 0);
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

version 0.001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


