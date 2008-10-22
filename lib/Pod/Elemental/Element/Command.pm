package Pod::Elemental::Element::Command;
our $VERSION = '0.001';

use Moose;
extends 'Pod::Elemental::Element';
# ABSTRACT: a POD =command element

use Moose::Autobox;

has children => (
  is   => 'ro',
  isa  => 'ArrayRef[Pod::Elemental::Element]',
  auto_deref => 1,
  required   => 1,
  default    => sub { [] },
);

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

version 0.001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


