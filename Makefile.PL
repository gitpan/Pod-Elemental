
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Pod-Elemental',
  NAME      => 'Pod::Elemental',
  AUTHOR    => 'Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>',
  ABSTRACT  => 'work\ with\ nestable\ POD\ elements',
  VERSION   => '0.091470',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Pod::Eventual::Simple" => '0.004',
    "Test::Deep" => '0',
    "Moose::Autobox" => '0.09',
    "Mixin::Linewise::Readers" => '0',
    "Moose" => '0',
  },
);
