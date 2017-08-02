<?php

namespace App\Services;

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
class LoggerFactory extends Monologger {

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
    }

    public function getLogger () 
    {
        return $this->monologger;
    }

}


