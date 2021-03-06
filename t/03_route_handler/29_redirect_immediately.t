use strict;
use warnings;

use Test::More import => ['!pass'];

use Dancer::Test;

use Dancer ':syntax';

plan tests => 5;

my $pass = 0;

before sub {
    redirect '/'
      unless request->path eq '/'
          || request->path eq '';
};

get '/' => sub { return "im home"; };
get '/false' => sub { $pass++; return "im false"; };

response_exists [ GET => '/' ];
response_content_is [ GET => '/' ], "im home";

response_exists [ GET => '/false' ];
response_headers_include [GET => '/false'] => ['Location'=>'/'];

is $pass, 0;
