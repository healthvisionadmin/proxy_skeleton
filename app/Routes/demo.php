<?php
namespace App\Routes;


$app->group('/demo', function () use ($app){
  $app->get('/hello', function ($request, $response, $args) {
     $response->write(' demo route hello ');
    return $response;
  });
  $app->get('/raise_error_500', function ($request, $response, $args) {
    throw new \Exception("Intentional 500, still caught");
    return $response;
  });
})->add( new \App\Middleware\TalkJsonOnly());
;
