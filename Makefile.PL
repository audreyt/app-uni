#!/usr/local/bin/perl

use strict;
use inc::Module::Install;

name           'App-Uni';
license        'CC0';
all_from       'lib/App/Uni.pm';
readme_from    'lib/App/Uni.pm';
repository     'http://github.com/audreyt/app-uni';
install_script 'bin/uni';

sign; WriteAll;

1;
