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
class MigrationsContext implements Context
{

  protected $mig;
  private $migcontainer;
  private $output;
    public function __construct()
    {
        $settings = require __DIR__ . '/../../../config/database.php';
        // follow all for migration testing
        $capsule   = new Capsule;
        $capsule->addConnection($settings);
        $capsule->setAsGlobal();
        $capsule->bootEloquent();
        $container = new ArrayObject();
        $container['phpmig.adapter'] = new Adapter\Illuminate\Database($capsule, 'migrations');
        $container['phpmig.migrations_path'] = __DIR__ . DIRECTORY_SEPARATOR . '../../../migrations';
        // $container['phpmig.migrations_template_path'] = $container['phpmig.migrations_path'] . DIRECTORY_SEPARATOR . '.template.php';
        $this->migcontainer = $container;
        // $output = new \Symfony\Component\Console\Output\NullOutput();
        $this->output = new \Symfony\Component\Console\Output\BufferedOutput();
        $this->mig = new PhpmigApplication($container, $this->output);
    }

    /**
     * @Given that Migration Status is:
     */
    public function thatMigrationStatusIs(PyStringNode $string)
    {
        $versionsUp = $this->migcontainer['phpmig.adapter']->fetchAll();
        $compare1 = [];
        foreach ($this->mig->getMigrations(0) as $migration) {
            $v = $migration->getVersion();
            $n = $migration->getName();
            if (in_array($migration->getVersion(), $versionsUp)) {
                $s = "up";
            } else {
                $s = "down";
            }
              $compare1[] = [$s,$v,$n];
            // $this->output->writeln($s . ' ' . $v . ' ' . $n);
        }
        $input = $string->getStrings(); // array of strings
        $compare2 = [];
        foreach ($input as $i) {
            $i = str_replace("  ", " ", $i);
            $i = str_replace("  ", " ", $i);
            $i = str_replace("  ", " ", $i);
            $i = str_replace("  ", " ", $i);
            $compare2[] = explode(" ", trim($i));
        }

        foreach ($compare2 as $c) {
          # code...
        }
        for ($i=0; $i < count($compare2); $i++) {
            PHPUnit_Framework_Assert::assertEquals($compare1[$i], $compare2[$i], 'Migrations status is not correct. First make sure, to up/down the named migration. Do so by running " php cli.php [up | down] [MigrationID]"');
        }
    }

    /**
         * @Given that I want update an existing :arg1 by method :arg2 with values:
         */
        public function thatIWantUpdateAnExistingByMethodWithValues($arg1, $arg2, $arg3)
        {
            // throw new PendingException();
            echo $arg3;
            echo "\n";
            echo $arg2;
            // var_dump($table->getColumnsHash());
            echo "\n";
        }




}
