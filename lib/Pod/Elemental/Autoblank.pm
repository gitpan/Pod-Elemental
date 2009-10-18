package Pod::Elemental::Autoblank;
our $VERSION = '0.092910';


use namespace::autoclean;
use Moose::Role;
# ABSTRACT: a paragraph that always displays an extra blank line in Pod form

around as_pod_string => sub {
  my ($orig, $self, @arg) = @_;
  my $str = $self->$orig(@arg);
  "$str\n";
};

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Autoblank - a paragraph that always displays an extra blank line in Pod form

=head1 VERSION

version 0.092910

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


