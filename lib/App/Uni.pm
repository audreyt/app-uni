#!/usr/bin/perl
package App::Uni;
use 5.008;
use strict;
use warnings;
use version;

our $VERSION = qv("v5.14.1");

sub main {
    binmode STDOUT, ':utf8';
    my $str = require 'unicore/Name.pl';

    open my $fh, '<', \$str
        or die "Cannot open unicore data: $!$/";

    my $regex = join ' ', @_;

    while (<$fh>) {
        chomp;
        (/$regex/io and /(.+)\t([^;]+)/) or next;

        my ($code, $name) = ($1, $2);
        ($name =~ /$regex/io or $code =~ /$regex/io) or next;

        next if $code =~ / /; # if we want to avoid named sequences
        my $chr = join q{}, map {; chr hex } split /\s+/, $code;
        print $code, ' ', $chr, ' ', $name, $/;
    }

    close $fh;
}

1;

__END__

=encoding utf8

=head1 NAME

App::Uni - Command-line utility to grep UnicodeData.txt

=head1 VERSION

This document describes version 0.02 of App::Uni, released December 10, 2009.

=head1 SYNOPSIS

    $ uni smiling
    263A ☺ WHITE SMILING FACE
    263B ☻ BLACK SMILING FACE

=head1 DESCRIPTION

This module installs a simple program, F<uni>, that helps grepping through
the Unicode database included in the current Perl 5 installation.

The arguments to the F<uni> program are joined with space and interpreted
as a regular expression.  Character codes or names matching the regex
(case-insensitively) are then printed out.

=head1 ACKNOWLEDGEMENTS

This is a re-implementation of a same-named program Larry copied to me,
which accompanied me for years.  However, that program was lost during a
hard disk failure, so I coded it up from memory.

Thank-you, Larry, for everything. ♡

=head1 AUTHORS

唐鳳 E<lt>cpan@audreyt.orgE<gt>

=head1 CC0 1.0 Universal

To the extent possible under law, 唐鳳 has waived all copyright and related
or neighboring rights to App-Uni.

This work is published from Taiwan.

L<http://creativecommons.org/publicdomain/zero/1.0>

=cut
