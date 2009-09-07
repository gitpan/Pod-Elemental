package Pod::Elemental::Document;
our $VERSION = '0.092500';

use Moose;
with 'Pod::Elemental::Node';
# ABSTRACT: a pod document

use Moose::Autobox;
use namespace::autoclean;

sub as_pod_string   {
  my ($self) = @_;

  join q{},
    "=pod\n\n",
    $self->children->map(sub { $_->as_pod_string })->flatten,
    "=cut\n";
}

sub as_debug_string { die }

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Document - a pod document

=head1 VERSION

version 0.092500

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


