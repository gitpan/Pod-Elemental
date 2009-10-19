package Pod::Elemental::Command;
our $VERSION = '0.092920';


use Moose::Role;
with 'Pod::Elemental::Paragraph' => { excludes => [ 'as_pod_string' ] };
# ABSTRACT: a =command paragraph

use Moose::Autobox;

requires 'command';

sub as_pod_string {
  my ($self) = @_;

  my $content = $self->content;

  sprintf "=%s%s", $self->command, ($content =~ /\S/ ? " $content" : "\n");
}

sub as_debug_string {
  my ($self) = @_;
  return sprintf '=%s', $self->command;
}

1;

__END__

=pod

=head1 NAME

Pod::Elemental::Command - a =command paragraph

=head1 VERSION

version 0.092920

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


