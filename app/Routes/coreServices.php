<?php
namespace App\Routes;


$app->group('/coreService', function () use ($app){
  
	$app->get('/initialisation/getSalt', 'App\Action\coreService\InitialisationController:getSalt');
	$app->post('/initialisation/verifyPin', 'App\Action\coreService\InitialisationController:verifyPin');
	$app->get('/initialisation/getUaid', 'App\Action\coreService\InitialisationController:getUaidByUid');
	$app->get('/initialisation/pki/uid', 'App\Action\coreService\InitialisationController:getPublicKeyByUid');
	$app->get('/initialisation/pki/uuid', 'App\Action\coreService\InitialisationController:getPublicKeyByUUID');


});
