package Pod::Elemental::Flat;
our $VERSION = '0.092930';


use Moose::Role;
# ABSTRACT: a content-only pod paragraph

use namespace::autoclean;

with 'Pod::Elemental::Paragraph';
excludes 'Pod::Elemental::Node';

sub as_debug_string {
  my ($self) = @_;

  my $moniker = ref $self;
  $moniker =~ s/\APod::Elemental::Element:://;

  my $summary = $self->_summarize_string($self->content);

  return "$moniker <$summary>";
}

1;

__END__
=pod

=head1 NAME

Pod::Elemental::Flat - a content-only pod paragraph

=head1 VERSION

version 0.092930

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

