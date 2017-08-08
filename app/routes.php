<?php
// Routes can be defined here or like
require __DIR__ . '/../app/Routes/demo.php';
require __DIR__ . '/../app/Routes/userServices.php';
require __DIR__ . '/../app/Routes/coreServices.php';
require __DIR__ . '/../app/Routes/appServices.php';
require __DIR__ . '/../app/Routes/helpServices.php';


$app->get('/', function ($request, $response, $args) use ($app) 
{
    /* we talk only json*/
    $answer = ['message'=>"hello"];
    $response->write(json_encode($answer));
    return $response;
})
// ->add( new \App\Middleware\TalkJsonOnly());
;


