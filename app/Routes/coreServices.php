<?php
namespace App\Routes;


$app->group('/coreService', function () use ($app){
  
	$app->get('/initialisation/getSalt', 'App\Action\coreService\InitialisationController:getSalt');


});
