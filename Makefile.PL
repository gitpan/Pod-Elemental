
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Pod-Elemental',
  NAME      => 'Pod::Elemental',
  AUTHOR    => "Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>",
  ABSTRACT  => "work\ with\ nestable\ POD\ elements",
  VERSION   => '0.092910',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "namespace::autoclean" => '0',
    "String::RewritePrefix" => '0',
    "Moose::Autobox" => '0.10',
    "Pod::Eventual::Simple" => '0.004',
    "Mixin::Linewise::Readers" => '0',
    "Test::Differences" => '0',
    "MooseX::Types" => '0',
    "Test::Deep" => '0',
    "Moose" => '0',
  },
  test => {TESTS => 't/*.t t/elem/*.t t/pod5/*.t'}
);

