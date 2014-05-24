#!/usr/bin/env perl
use strict;
use warnings;

# use Data::Dumper;


my $str = <<EOF;


csslint: There are 2 problems in /Users/oppara/tmp/css.css.

css.css
1: warning at line 6, col 1
Don't use IDs in selectors.
#foobar {

css.css
2: warning at line 12, col 3
vertical-align can't be used with display: block.
  vertical-align: baseline;

EOF

# my @lines = split( "\n", $str );
my @lines = <STDIN>;

my $br = '';
foreach my $line ( @lines ) {
    chomp($line);
    next if $line =~ /^csslint/;
    if ( $line =~ /^\s*$/ ) {
        print $br;
        $br = '';
        next;
    }

    if ( $line =~ /^.+ at line (\d+), col (\d+)/ ) {
        print "[$1,$2]";
        next;
    }

    print $line;
    $br = "\n";
}

