<?php
namespace App\Middleware;


class TalkJsonOnly
{
    /**
     * when app is needed use this 
     * and construct it like
     * $app->add( new \App\Middleware\TalkJsonOnly($app));
     * 
     **/
    
    // protected $app;
    // public function __construct(\Slim\App $app)
    // {
    //     $this->app = $app;
    // }

    public function __invoke($request, $response, $next)
    {
     $jsonResponse = $response->withHeader('Content-type', 'application/json');
     $response = $next($request, $jsonResponse);
     return $response;


 }
}
