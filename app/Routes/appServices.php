<?php
namespace App\Routes;


$app->group('/appService', function () use ($app){
  
	$app->get('/fontService', 'App\Action\appService\FontServiceController:getFonts');

	$app->get('/softwareLibrary/getCode', 'App\Action\appService\SoftwareLibraryController:getCode');

	$app->get('/imageService', 'App\Action\appService\ImageServiceController:getImageById');

	

});
