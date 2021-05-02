#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use SdB::App;
use SdB::TESTB;  ###
use SdB::TESTC;  ###
use SdB::TESTD;  ###

SdB::App->to_app;

use Plack::Builder;

builder {
    enable 'Deflater';
    SdB::App->to_app;
}



=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use SdB::App;
use Plack::Builder;

builder {
    enable 'Deflater';
    SdB::App->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use SdB::App;
use SdB::App_admin;

builder {
    mount '/'      => SdB::App->to_app;
    mount '/admin'      => SdB::App_admin->to_app;
}

=end comment

=cut

