use v5.12.0;
package App::Uni v0.12.0;
use open ':std' => ':utf8';

sub main {
    my ($file) = grep { -f and -r }
                  map { "$_/unicore/UnicodeData.txt" } @INC
        or die 'Cannot find UnicodeData.txt in @INC';

    utf8::decode(
        my $regex = join(' ', @_)
    );

    if (length $regex == 1) {
        $regex = sprintf('(?:%s|%04X)', $regex, ord $regex);
    }

    open my $fh, '<:mmap', $file;
    for (<$fh>) {
        if (/$regex/io and my ($code, $name) = /(\w+);([^;]+)/) {
            say $code, ' ', chr hex $code, ' ', $name
                if [$name, $code] ~~ /$regex/io;
        }
    }
    close $fh;
}

1;

__END__

=encoding utf8

=head1 NAME

App::Uni - Command-line utility to grep UnicodeData.txt

=head1 VERSION

This document describes version v0.12.0 of App::Uni, released April 13, 2010.

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
