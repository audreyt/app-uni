#!/usr/local/bin/perl

use v5.12.0;
use inc::Module::Install;

name           'App-Uni';
license        'CC0';

given ('lib/App/Uni.pm') {
    all_from $_;
    readme_from $_;
    readme_markdown_from $_;
}

repository     'http://github.com/audreyt/app-uni';
install_script 'bin/uni';

sign; WriteAll;

1;
