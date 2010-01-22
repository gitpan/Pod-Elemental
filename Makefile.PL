
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t t/elem/*.t t/pod5/*.t'
                                 },
                       'NAME' => 'Pod::Elemental',
                       'DISTNAME' => 'Pod-Elemental',
                       'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
                       'ABSTRACT' => 'work with nestable Pod elements',
                       'EXE_FILES' => [],
                       'VERSION' => '0.100220',
                       'LICENSE' => 'perl',
                       'PREREQ_PM' => {
                                        'String::Truncate' => '0',
                                        'namespace::autoclean' => '0',
                                        'ExtUtils::MakeMaker' => '6.11',
                                        'String::RewritePrefix' => '0',
                                        'Pod::Eventual::Simple' => '0.004',
                                        'Moose::Autobox' => '0.10',
                                        'Mixin::Linewise::Readers' => '0',
                                        'Encode' => '0',
                                        'Test::Differences' => '0',
                                        'Sub::Exporter::ForMethods' => '0',
                                        'MooseX::Types' => '0',
                                        'Test::Deep' => '0',
                                        'Moose' => '0'
                                      }
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



