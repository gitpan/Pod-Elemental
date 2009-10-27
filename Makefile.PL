
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Pod-Elemental',
  NAME      => 'Pod::Elemental',
  AUTHOR    => "Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>",
  ABSTRACT  => "work\ with\ nestable\ Pod\ elements",
  VERSION   => '0.093000',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "String::Truncate" => '0',
    "namespace::autoclean" => '0',
    "String::RewritePrefix" => '0',
    "Moose::Autobox" => '0.10',
    "Pod::Eventual::Simple" => '0.004',
    "Encode" => '0',
    "Mixin::Linewise::Readers" => '0',
    "Test::Differences" => '0',
    "MooseX::Types" => '0',
    "Sub::Exporter::ForMethods" => '0',
    "Test::Deep" => '0',
    "Moose" => '0',
  },
  test => {TESTS => 't/*.t t/elem/*.t t/pod5/*.t'}
);

