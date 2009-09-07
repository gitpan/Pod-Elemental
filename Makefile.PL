
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Pod-Elemental',
  NAME      => 'Pod::Elemental',
  AUTHOR    => 'Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>',
  ABSTRACT  => 'work\ with\ nestable\ POD\ elements',
  VERSION   => '0.092500',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Moose::Autobox" => '0.09',
    "Test::Deep" => '0',
    "Pod::Eventual::Simple" => '0.004',
    "Moose" => '0',
    "Mixin::Linewise::Readers" => '0',
  },
);
