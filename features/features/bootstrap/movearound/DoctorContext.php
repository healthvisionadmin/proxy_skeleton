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

// for Guzzle to cURL output
use Namshi\Cuzzle\Formatter\CurlFormatter;
use GuzzleHttp\Client;
use GuzzleHttp\Message\Request;
use GuzzleHttp\Message\Response;

/**
 * Defines application features from the specific context.
 */
class DoctorContext implements Context
{

    private $migcontainer;
    private $output;
    /**
      * @var Phpmig\Api\PhpmigApplication
      */
    protected $mig;

     /**
      * @var GuzzleHttp\Client
      */
    protected $client;

    /**
     * @var \GuzzleHttp\Psr7\Request
     */
    protected $request;
     /**
      * @var Array
      */
    protected $headers;

     /**
      * @var GuzzleHttp\Psr7\Response
      */
    protected $response;

     /**
      * @var string
      */
    protected $requestMethod;

     /**
      * @var string
      */
    protected $base_url;

     /**
      * @var string
      */
    protected $resource;

     /*
      * @var array
     */
    protected $decoded_bearer;

    protected $asCurl;

    public function __construct()
    {
        $settings = require __DIR__ . '/../../../app/settings.php';
        // follow all for migration testing
        $capsule   = new Capsule;
        $capsule->addConnection($settings['settings']['database']);
        $capsule->setAsGlobal();
        $capsule->bootEloquent();
        $container = new ArrayObject();
        $container['phpmig.adapter'] = new Adapter\Illuminate\Database($capsule, 'migrations');
        $container['phpmig.migrations_path'] = __DIR__ . DIRECTORY_SEPARATOR . '../../../migrations';
        $this->migcontainer = $container;
        $this->output = new \Symfony\Component\Console\Output\BufferedOutput();
        $this->mig = new PhpmigApplication($container, $this->output);

        // Guzzle
        $this->base_url = $settings['app']["url"];
        $this->client  = new GuzzleHttp\Client([
          'base_uri' => $this->base_url,
        ]);
        // $this->request = new GuzzleHttp\Psr7\Request();
        $this->response = new GuzzleHttp\Psr7\Response();

        $this->headers = array(
            'Authorization' => '',
            'Content-Type' => 'application/json'
        );
        
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
    * @Given that I have a :arg1 Authorization
    * valid / invalid / admin / todo: other access rights
    * see __DIR__/authoriziation_headers
    */
     public function thatIHaveAAuthorization($arg1)
     {
          $auth_header = file_get_contents (__DIR__."/authoriziation_headers/".$arg1);
          $this->headers['Authorization']=$auth_header;
     }


     /**
            * @When I request :arg1 with Method :arg2
            *
            */
    public function iRequestWithMethod($arg1, $arg2)
    {
        try {
            $headers = array("headers"=>$this->headers);
            $uri = $this->base_url.$arg1;
            // var_dump($uri);
            // var_dump($arg2);
            // var_dump($this->headers);
            $this->request = new \GuzzleHttp\Psr7\Request($arg2, $uri, $this->headers);
            $this->response = $this->client->send($this->request, $this->headers);
            // echo "dsadsa";
            $this->asCurl = (new CurlFormatter(100000))->format(new \GuzzleHttp\Psr7\Request($arg2, $uri, $this->headers));
            // echo $this->asCurl;
            // var_dump(get_class_methods($this->client));

        } catch (GuzzleHttp\Exception\ClientException $e) {
             // updating response
          $this->response = $e->getResponse();
             // echo ($e->getResponse()->getBody());
            // $stream = $e->getResponse()->getBody();
            // $stream->rewind(); // Seek to the beginning
            // $contents = $stream->getContents(); // returns all the contents
            // $body = json_decode($contents);
            // if (json_last_error() !== JSON_ERROR_NONE) {
            //     $body = [];
            // }
            // $this->response = new \GuzzleHttp\Psr7\Response(
            //     $e->getResponse()->getStatusCode(),
            //     ['content-type' => $e->getResponse()->getHeader('content-type')]
            // );
        }
    }

    /**
     * @Then I want to see the curl of the query
     */
    public function iWantToSeeTheCurlOfTheQuery()
    {
        echo $this->asCurl;
    }

    /**
     * @Given I want create an :arg1 by method :arg2 with values:
     */
    public function iWantCreateAnByMethodWithValues($arg1, $arg2, TableNode $table)
    {
        try {

            // $row = $table->getRowsHash();
            $data  = $table->getRowsHash();
            // var_dump($this->headers['Authorization']);
            $r = array(
                $arg2,
                $arg1,
                [
                   'Authorization' => $this->headers['Authorization'],
                   'Content-Type' => 'application/x-www-form-urlencoded'

                ],
                http_build_query($data, null, '&')
            );
            $request = new GuzzleHttp\Psr7\Request(...$r);
            // adding base_uri to curl
            $r[1]=$this->base_url.$arg1;
            $this->asCurl = (new CurlFormatter(100000))->format(new GuzzleHttp\Psr7\Request(...$r));
            // possibly this raises an exeption
            $this->response = $this->client->send( $request );

        } catch (GuzzleHttp\Exception\ClientException $e) {
          // updating response
          $this->response = $e->getResponse();
         }
    }


    /**
     * @Given I want to see the Response
     */
    public function iWantToSeeTheResponse()
    {
       $response = $this->response;
      $stream = $response->getBody();
      $contents = $stream->getContents(); // returns all the
// echo $response->getProtocol();        // >>> HTTP
// echo $response->getProtocolVersion(); // >>> 1.1
      echo "Status Code: " .$response->getStatusCode();
      echo "\nReason Phrase: " .$response->getReasonPhrase();    // >>> OK
       echo "\nContent: " .$contents . "\n";
    }


    /**
     * @Then the response status code should be :arg1
     */
    public function theResponseStatusCodeShouldBe($arg1)
    {
      $response = $this->response;
      $stream = $response->getBody();
      $contents = $stream->getContents(); // returns all the
        PHPUnit_Framework_Assert::assertEquals(
            intval($arg1),
            $this->response->getStatusCode(),
            "Debug: " . $this->response->getStatusCode() . ' Content: ' . $contents
        );
    }

        /**
            * @Then the response should contain attribute :arg1 with :arg2 Elements
            */
    public function theResponseShouldContainAttributeWithElements($arg1, $arg2)
    {
               $b = $this->response->getBody();
               $a = json_decode($b, true);
               PHPUnit_Framework_Assert::assertNotNull($a[$arg1]);
               PHPUnit_Framework_Assert::assertEquals(count($a[$arg1]), $arg2);
    }


      /**
     * @Then I internal internal HTTP-ERROR should be :arg1
     */
    public function iInternalInternalHttpErrorShouldBe($arg1)
    {
        $b = $this->response->getBody();
        $a = json_decode($b, true);
        PHPUnit_Framework_Assert::assertNotNull($a['error']);
        PHPUnit_Framework_Assert::assertEquals((int)$a['error']['http_code'], $arg1);

    }



    /**
     * @Then the Element nr. :arg3 of :arg1 should have attribute :arg2 with value :arg4
     */
    public function theElementNrOfShouldHaveAttributeWithValue($arg1, $arg2, $arg3, $arg4)
    {
        $b = $this->response->getBody();
        $a = json_decode($b, true);
        // var_dump($a);
        // var_dump($arg2);
        // PHPUnit_Framework_
        PHPUnit_Framework_Assert::assertNotNull($a[$arg1]);
        PHPUnit_Framework_Assert::assertNotNull($a[$arg1][$arg3][$arg2]);
        PHPUnit_Framework_Assert::assertEquals($a[$arg1][$arg3][$arg2], $arg4);
    }







}
