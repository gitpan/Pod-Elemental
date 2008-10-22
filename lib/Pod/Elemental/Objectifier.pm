package Pod::Elemental::Objectifier;
our $VERSION = '0.001';

use Moose;
use Moose::Autobox;
# ABSTRACT: it turns a Pod::Eventual event stream into objects

use Pod::Elemental::Element::Command;
use Pod::Elemental::Element::Nonpod;
use Pod::Elemental::Element::Text;

sub element_class_for_event_type {
  my ($self, $t) = @_;
  return 'Pod::Elemental::Element::Command' if $t eq 'command';
  return 'Pod::Elemental::Element::Text' if $t eq 'verbatim' or $t eq 'text';
  return 'Pod::Elemental::Element::Nonpod' if $t eq 'nonpod';
  Carp::croak "unknown event type: $t";
}

sub objectify_events {
  my ($self, $events) = @_;
  return $events->map(sub {
    Carp::croak("not a valid event") unless ref $_;

    my $class = $self->element_class_for_event_type($_->{type});

    my %guts = (
      type       => $_->{type},
      content    => $_->{content},
      start_line => $_->{start_line},

      ($_->{type} eq 'command' ? (command => $_->{command}) : ()),
    );

    chomp for values %guts;

    $class->new(\%guts);
  });
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Pod::Elemental::Objectifier - it turns a Pod::Eventual event stream into objects

=head1 VERSION

version 0.001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


