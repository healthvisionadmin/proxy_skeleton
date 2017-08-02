<?php

use Behat\Behat\Context\Context;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Tester\Exception\PendingException;

require ('vendor/autoload.php');
use Illuminate\Database\Capsule\Manager as Capsule;
use Phpmig\Console\Command;
use Phpmig\Api\PhpmigApplication;
use Phpmig\Adapter;

/**
 * Defines application features from the specific context.
 */
class DatabaseContext implements Context
{

  protected $mig;
  private $migcontainer;
  private $output;
  private $db;
    public function __construct($param)
    {
        if (isset($param['db_settings'])) {
            $settings = require __DIR__ . '/db_settings/'.$param['db_settings'];
        } else {
            $settings = require __DIR__ . '/../../../config/database.php';
        }
        // follow all for migration testing
        $this->db   = new Capsule;
        $this->db->addConnection($settings);
        $this->db->setAsGlobal();
        $this->db->bootEloquent();
        $container = new ArrayObject();
        $container['phpmig.adapter'] = new Adapter\Illuminate\Database($this->db, 'migrations');
        $container['phpmig.migrations_path'] = __DIR__ . DIRECTORY_SEPARATOR . '../../../migrations';
        // $container['phpmig.migrations_template_path'] = $container['phpmig.migrations_path'] . DIRECTORY_SEPARATOR . '.template.php';
        $this->migcontainer = $container;
        // $output = new \Symfony\Component\Console\Output\NullOutput();
        $this->output = new \Symfony\Component\Console\Output\BufferedOutput();
        $this->mig = new PhpmigApplication($container, $this->output);
    }

    /**
     * @Given that we use Database :arg1
     */
    public function thatWeUseDatabase($arg1)
    {
        /* 
        with 
        $res = Capsule::select('show databases');
        we can write plain sql 
        */
        // $res = Capsule::select('show databases');
        // dd($res);

        throw new PendingException();
    }




}
