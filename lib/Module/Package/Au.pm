use v5.12.0;
use utf8;
use strict;
package Module::Package::Au;

our $VERSION = '0.01';

use Module::Package 0.24 ();
use Module::Install::GithubMeta 0.10 ();
use Module::Install::ReadmeFromPod 0.12 ();
use Module::Install::ReadmeMarkdownFromPod 0.03 ();
use Pod::Markdown 1.110730 ();


package Module::Package::Au::現代;
use Module::Package::Plugin;
our @ISA = 'Module::Package::Plugin';

sub main {
    my ($self) = @_;

    $self->mi->license('CC0');
    $self->mi->readme_from($self->pod_or_pm_file);
    $self->mi->readme_markdown_from($self->pod_or_pm_file);
    $self->mi->sign;  # XXX Not sure it this needs to be post_all_from
    $self->mi->clean_files('README.mkdn');
 
    $self->post_all_from(sub {$self->mi->githubmeta});
}

1;
