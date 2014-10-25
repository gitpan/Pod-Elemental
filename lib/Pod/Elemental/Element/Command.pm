package Pod::Elemental::Element::Command;
our $VERSION = '0.091470';

use Moose;
extends 'Pod::Elemental::Element';
with 'Pod::Elemental::Role::Children';
# ABSTRACT: a POD =command element

use Moose::Autobox;

has '+type' => (default => 'command');


has command => (is => 'ro', isa => 'Str', required => 0);

sub as_hash {
  my ($self) = @_;

  my $hash = {
    type    => $self->type,
    content => $self->content,
    command => $self->command,
  };

  $hash->{children} = $self->children->map(sub { $_->as_hash })
    if $self->children->length;

  return $hash;
}

sub as_string {
  my ($self) = @_;

  my @para;

  push @para, sprintf "=%s %s\n", $self->command, $self->content;
  if ($self->children->length) {
    push @para, $self->children->map(sub { $_->as_string })->flatten;
  }

  push @para, "=back\n" if $self->command eq 'over';
  push @para, ('=end ' . $self->content . "\n") if $self->command eq 'begin';

  return join "\n", @para;
}

sub as_debug_string {
  my ($self) = @_;

  my @para;

  push @para, sprintf "=%s %s\n", $self->command, $self->content;
  if ($self->children->length) {
    my @sub = $self->children->map(sub { $_->as_debug_string })->flatten;
    s/^/  /gm for @sub;
    push @para, @sub;
  }

  push @para, "=back\n" if $self->command eq 'over';
  push @para, ('=end ' . $self->content . "\n") if $self->command eq 'begin';

  return join "", @para;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Element::Command - a POD =command element

=head1 VERSION

version 0.091470

=head1 ATTRIBUTES

=head2 command

This attribute contains the name of the command, like C<head1> or C<encoding>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


