package Pod::Elemental;
our $VERSION = '0.001';

use Moose;
use Moose::Autobox;
# ABSTRACT: work with nestable POD elements

use Mixin::Linewise::Readers -readers;
use Pod::Elemental::Element;
use Pod::Elemental::Nester;
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

has nester => (
  is => 'ro',
  required => 1,
  default  => sub { return Pod::Elemental::Nester->new },
);

sub read_handle {
  my ($self, $handle) = @_;
  $self = $self->new unless ref $self;

  my $events   = $self->event_reader->read_handle($handle)
                 ->grep(sub { $_->{type} ne 'nonpod' });
  my $elements = $self->objectifier->objectify_events($events);
  $self->nester->nest_elements($elements);

  return $elements;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental - work with nestable POD elements

=head1 VERSION

version 0.001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


