#!/usr/bin/perl
package App::Uni;
use 5.008;
use utf8;
use strict;
use warnings;
use constant SOURCE => 'unicore/UnicodeData.txt';
our $VERSION = '0.03';

sub main {
    my ($file) = grep -f, map { "$_/".SOURCE } @INC
        or die "Cannot find: ".SOURCE.$/;

    binmode STDOUT, ':utf8';
    open my $fh, '<', $file
        or die "Cannot open $file: $!$/";

    my $regex = join ' ', @_;
    utf8::decode($regex);

    if (length $regex == 1) {
        $regex = sprintf('(?:%s|%04X)', $regex, ord $regex);
    }

    while (<$fh>) {
        (/$regex/io and /(\w+);([^;]+)/) or next;

        my ($code, $name) = ($1, $2);
        ($name =~ /$regex/io or $code =~ /$regex/io) or next;

        print $code, ' ', chr hex $code, ' ', $name, $/;
    }

    close $fh;
}

1;

__END__

=encoding utf8

=head1 NAME

App::Uni - Command-line utility to grep UnicodeData.txt

=head1 VERSION

This document describes version 0.03 of App::Uni, released December 11, 2009.

=head1 SYNOPSIS

    $ uni smiling face
    263A ☺ WHITE SMILING FACE
    263B ☻ BLACK SMILING FACE

    $ uni ☺
    263A ☺ WHITE SMILING FACE

=head1 DESCRIPTION

This module installs a simple program, F<uni>, that helps grepping through
the Unicode database included in the current Perl 5 installation.

The arguments to the F<uni> program are joined with space and interpreted
as a regular expression.  Character codes or names matching the regex
(case-insensitively) are then printed out.

If the argument is a single character, then the character itself is also
printed out in addition to code and name matches.

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
