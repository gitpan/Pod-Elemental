use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.034

use Test::More 0.94 tests => 26;



my @module_files = (
    'Pod/Elemental.pm',
    'Pod/Elemental/Autoblank.pm',
    'Pod/Elemental/Autochomp.pm',
    'Pod/Elemental/Command.pm',
    'Pod/Elemental/Document.pm',
    'Pod/Elemental/Element/Generic/Blank.pm',
    'Pod/Elemental/Element/Generic/Command.pm',
    'Pod/Elemental/Element/Generic/Nonpod.pm',
    'Pod/Elemental/Element/Generic/Text.pm',
    'Pod/Elemental/Element/Nested.pm',
    'Pod/Elemental/Element/Pod5/Command.pm',
    'Pod/Elemental/Element/Pod5/Data.pm',
    'Pod/Elemental/Element/Pod5/Nonpod.pm',
    'Pod/Elemental/Element/Pod5/Ordinary.pm',
    'Pod/Elemental/Element/Pod5/Region.pm',
    'Pod/Elemental/Element/Pod5/Verbatim.pm',
    'Pod/Elemental/Flat.pm',
    'Pod/Elemental/Node.pm',
    'Pod/Elemental/Objectifier.pm',
    'Pod/Elemental/Paragraph.pm',
    'Pod/Elemental/Selectors.pm',
    'Pod/Elemental/Transformer.pm',
    'Pod/Elemental/Transformer/Gatherer.pm',
    'Pod/Elemental/Transformer/Nester.pm',
    'Pod/Elemental/Transformer/Pod5.pm',
    'Pod/Elemental/Types.pm'
);



# no fake home requested

use File::Spec;
use IPC::Open3;
use IO::Handle;

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, '-Mblib', '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



# no warning checks;

BAIL_OUT("Compilation problems") if !Test::More->builder->is_passing;
