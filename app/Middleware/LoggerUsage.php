<?php

namespace App\Middleware;

use Monolog\Logger as Monologger;
use Monolog\Handler\RotatingFileHandler;
use Monolog\Handler\StreamHandler;
use Monolog\Handler\NullHandler;
use Monolog\Formatter\LineFormatter;
use Psr\Log\LoggerInterface;

/**
 * Class Logger used as middleware
 * 
 * it produces log files named by date
 */
class LoggerUsage extends Monologger {

    protected $monologger;


    /**
     * Logger constructor.
     *
     * @param array $settings Settings
     *
     */
    public function __construct($settings = array())
    {
        $this->monologger = new Monologger($settings['name']);

        $formatter = new LineFormatter(
            "[%datetime%] [%level_name%]: %message% %context%\n",
            null,
            true,
            true
        );
        /* Log to timestamped files */
        $rotating = new RotatingFileHandler($settings['path'], 0, Monologger::DEBUG);
        $rotating->setFormatter($formatter);
        $this->monologger->pushHandler($rotating);
        // $this->monologger->pushHandler(new StreamHandler($settings['path']));

    }


    /**
     * Logger Middleware for Slim framework
     * 
     * @todo : make this tracking usefull infos
     *
     * @return \Psr\Http\Message\ResponseInterface
     */
    public function __invoke($request, $response, $next)
    {
        $start = microtime();
        $path = $request->getUri()->getPath();
        $response = $next($request, $response);
        $end = microtime();
        $latency = $end - $start;
        // Client IP address
        // $clientIP = $this->getIpAddress();
        $clientIP = "anonym";
        // Method access
        $method = $request->getMethod();
        $logtext = sprintf("|%d|%f s|%s|%s %s", $response->getStatusCode(), $latency, $clientIP, $method, $path);
        $this->monologger->info($logtext);
        return $response;
    }


}


