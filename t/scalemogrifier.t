#!perl

use warnings;
use strict;

use Test::More;

use lib 't';
use Util;

my @tests = (
  { name     => 'default',
    cmd      => [qw{./scalemogrifier}],
    expected => q{c d e f g a b c'},
    lines    => 1,
  },
  { name     => 'aeolian a',
    cmd      => [qw{./scalemogrifier --mode=minor --transpose=a}],
    expected => q{a b c d e f g a'},
    lines    => 1,
  },
  { name     => 'raw',
    cmd      => [qw{./scalemogrifier --raw}],
    expected => q{0 2 4 5 7 9 11 12},
    lines    => 1,
  },
);

# by three as Util.pm has a was-something-on-stderr test in addition to
# the two in the loop below
plan tests => @tests * 3;

for my $test (@tests) {
  my @output = run_util( @{ $test->{cmd} } );
  is( $output[0],     $test->{expected}, $test->{name} . " output" );
  is( scalar @output, $test->{lines},    $test->{name} . " lines" );
}
