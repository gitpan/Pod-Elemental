
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'work with nestable Pod elements',
  'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
  'BUILD_REQUIRES' => {
    'Data::Dumper' => '0',
    'Test::Deep' => '0',
    'Test::Differences' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Pod-Elemental',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Pod::Elemental',
  'PREREQ_PM' => {
    'Encode' => '0',
    'Mixin::Linewise::Readers' => '0',
    'Moose' => '0',
    'Moose::Autobox' => '0.10',
    'Moose::Role' => '0',
    'Moose::Util::TypeConstraints' => '0',
    'MooseX::Types' => '0',
    'MooseX::Types::Moose' => '0',
    'Pod::Eventual::Simple' => '0.004',
    'String::RewritePrefix' => '0',
    'String::Truncate' => '0',
    'Sub::Exporter' => '0',
    'Sub::Exporter::ForMethods' => '0',
    'Test::Deep' => '0',
    'Test::Differences' => '0',
    'namespace::autoclean' => '0',
    'utf8' => '0'
  },
  'VERSION' => '0.101620',
  'test' => {
    'TESTS' => 't/*.t t/elem/*.t t/pod5/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



