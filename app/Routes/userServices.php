<?php
namespace App\Routes;


$app->group('/userService', function () use ($app){

  	$app->get('/hello', function ($request, $response, $args) {
     	$response->write('demo route hello');
    	return $response;
  	});
  
	$app->post('/create', 'App\Action\userService\UserController:create');
	$app->post('/update', 'App\Action\userService\UserController:update');
	$app->get('/delete', 'App\Action\userService\UserController:delete');


})->add( new \App\Middleware\TalkJsonOnly());
