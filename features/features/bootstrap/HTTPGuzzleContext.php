<?php
// features/bootstrap/FeatureContext.php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;


require ('vendor/autoload.php');


use GuzzleHttp\Client;
use GuzzleHttp\Psr7\Request;

use Illuminate\Database\Capsule\Manager as Capsule;
use Phpmig\Console\Command;
use Phpmig\Api\PhpmigApplication;
use Phpmig\Adapter;


use Symfony\Component\Console\Tester\CommandTester;
use Symfony\Component\EventDispatcher\EventDispatcher;
use Firebase\JWT\JWT;




class HTTPGuzzleContext implements SnippetAcceptingContext
{
    private $slimapp;
    private $migcontainer;
    private $output;



    /** @var Phpmig\Api\PhpmigApplication
     */
    protected $mig;

    /**
     * @var GuzzleHttp\Client
     */
    protected $client;

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

    public function __construct($param)
    {
      if (isset($parameters['db_settings'])) {
            $settings = require __DIR__ . '/db_settings/'.$parameters['db_settings'];
        } else {
            $settings = require __DIR__ . '/../../../config/database.php';
        }
      // $this->base_url = $settings['app']["url"];

      $this->client = new GuzzleHttp\Client([
          'base_uri' => $this->base_url,
      ]);
      $this->response = new GuzzleHttp\Psr7\Response();


      //
      // follow all for migration testing
      $capsule   = new Capsule;
      $capsule->addConnection($settings['database']);
      $capsule->setAsGlobal();
      $capsule->bootEloquent();
      $container = new ArrayObject();
      $container['phpmig.adapter'] = new Adapter\Illuminate\Database($capsule, 'migrations');
      $container['phpmig.migrations_path'] = __DIR__ . DIRECTORY_SEPARATOR . '../../migrations';
      // $container['phpmig.migrations_template_path'] = $container['phpmig.migrations_path'] . DIRECTORY_SEPARATOR . '.template.php';
      $this->migcontainer = $container;
      // $output = new \Symfony\Component\Console\Output\NullOutput();
      $this->output = new \Symfony\Component\Console\Output\BufferedOutput();
      $this->mig = new PhpmigApplication($container, $this->output);
      // $this->mig->addCommands(array(new Command\StatusCommand()));
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
   * fails with JWT Exception when decoding goes wrong / bearer is invalid
   */
   /**
    * @When I decrypt the Auth-Bearer with secret :arg1
    */
    public function iDecryptTheAuthBearerWithSecret($arg1)
    {
        // cut of "Bearer "
        $bearer = substr($this->headers['Authorization'], 7);
        // $decoded = \Firebase\JWT\JWT::decode($this->headers['Authorization'], $arg1, array('HS256'));
        try {
            $decoded = \Firebase\JWT\JWT::decode($bearer, $arg1, array('HS256'));
            $this->decoded_bearer = $decoded;
        } catch (Exception $e) {
            // var_dump(get_class_methods($e));
            echo "Somethinh wrong with secret but progressing\n";
            echo "Following tests will fail probably \n";
            echo $e->getMessage();
            echo "\n";
            echo $e->getCode();
        }

    }


    /**
     * @Then the decrypted Auth-Bearer-Data for :arg1 should be :arg2
     */
    public function theDecryptedAuthBearerDataForShouldBe($arg1, $arg2)
    {
        $data = (array)$this->decoded_bearer->data;
        PHPUnit_Framework_Assert::assertEquals($data[$arg1], $arg2);
    }





    /**
       * @When I request :arg1 with Method :arg2
       *
       */
      public function iRequestWithMethod($arg1, $arg2)
      {
        try {
          $this->response = $this->client->request($arg2, $arg1,  array("headers"=>$this->headers));
        } catch (GuzzleHttp\Exception\ClientException $e) {
            $stream = $e->getResponse()->getBody();
            $stream->rewind(); // Seek to the beginning
            $contents = $stream->getContents(); // returns all the contents
            $body = json_decode($contents);
            if (json_last_error() !== JSON_ERROR_NONE) {
              $body = [];
            }
          $this->response = new \GuzzleHttp\Psr7\Response(
                $e->getResponse()->getStatusCode(),
                $body
                // json_decode($e->getResponse()->getBody())
            );
        }
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
       * @Then the response status code should be :arg1
       */
      public function theResponseStatusCodeShouldBe($arg1)
      {
          PHPUnit_Framework_Assert::assertEquals(
              intval($arg1),
               $this->response->getStatusCode()
          );
      }


   /**
    * @Then the :arg1 header should be :arg2
    */
   public function theHeaderShouldBe($arg1, $arg2)
   {
       throw new PendingException();
   }

   /**
    * @Then the :arg1 property should equal :arg2
    */
   public function thePropertyShouldEqual($arg1, $arg2)
   {
       throw new PendingException();
   }


   /**
   * @Given I have the payload:
   */
 //  public function iHaveThePayload(PyStringNode $string)
 //  {
 //     //  var_dump($string);
 //      $app = $this->slimapp;
 //      $request = $this->client->get('http://localhost/health/s3_1/public/api/doctor', array(
 //   'headers' => array("Authorization"=>"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE0ODA1Mjc1NTksImp0aSI6IktqQT0iLCJpc3MiOiJsb2NhbGhvc3QiLCJuYmYiOjE0ODA1Mjc1NTksImV4cCI6MTU0MjczNTU1OSwiZGF0YSI6eyJoZWxsbyI6Ind1cnN0In19.Ps-pMwymWCmrKRSI2xrkYsYxXCux_XsLI0T5wEkJH4A")
 // ));
 //     $versionsUp = $this->migcontainer['phpmig.adapter']->fetchAll();

 //     foreach($this->mig->getMigrations(0) as $migration) {
 //         echo ($migration->getName());
 //         echo "\n";
 //         echo ($migration->getVersion());
 //         echo "\n";
 //         echo "\n";
 //         echo "\n";

 //         if (in_array($migration->getVersion(), $versionsUp)) {
 //             $status = "     <info>up</info> ";
 //             unset($versionsUp[array_search($migration->getVersion(), $versionsUp)]);
 //         } else {
 //             $status = "   <error>down</error> ";
 //         }

 //         $this->output->writeln(
 //             $status .
 //             sprintf(" %14s ", $migration->getVersion()) .
 //             " <comment>" . $migration->getName() . "</comment>"
 //         );
 //     }

 //     echo ($this->output->fetch());
 //      try {

 //          // $this->buildRequest();

 //      } catch(\GuzzleHttp\Exception\ClientException $e) {

 //          $this->response = new \GuzzleHttp\Message\Response(
 //              $e->getResponse()->getStatusCode(),
 //              ['content-type' => $e->getResponse()->getHeader('content-type')]
 //          );

 //      }
    
 //      throw new PendingException();
 //  }


    /**
     * @Given there is a :product, which costs £:price
     */
    public function thereIsAWhichCostsPs($product, $price)
    {
        $this->shelf->setProductPrice($product, floatval($price));
    }

    /**
     * @When I add the :product to the basket
     */
    public function iAddTheToTheBasket($product)
    {
        $this->basket->addProduct($product);
    }

    /**
     * @Then I should have :count product(s) in the basket
     */
    public function iShouldHaveProductInTheBasket($count)
    {
        PHPUnit_Framework_Assert::assertCount(
            intval($count),
            $this->basket
        );
    }

    /**
     * @Then the overall basket price should be £:price
     */
    public function theOverallBasketPriceShouldBePs($price)
    {
        PHPUnit_Framework_Assert::assertSame(
            floatval($price),
            $this->basket->getTotalPrice()
        );
    }
}
