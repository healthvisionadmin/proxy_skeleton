<?php
namespace App\Routes;


$app->group('/help', function () use ($app){
  
	$app->get('/{permalink}', 'App\Action\helpService\HelpServiceController:index');

	

});
