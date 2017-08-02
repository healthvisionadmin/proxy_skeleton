<?php
// features/bootstrap/FeatureContext.php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;


require ('vendor/autoload.php');


use GuzzleHttp\Client;
// // use GuzzleHttp\Psr7;
// // use Psr\Http\Message\RequestInterface;
// use Psr\Http\Message;
// use GuzzleHttp\Message\Response;
use GuzzleHttp\Psr7\Request;
// // use GuzzleHttp\Message\Response;
// use Psr\Http\Message\UriInterface;



// For PHP CLI (Migartion )
// use Helpers\Commands\CreateActionCommand;
// use Helpers\Commands\CreateMiddlewareCommand;
// use Helpers\Commands\CreateModelCommand;
// use Helpers\Commands\CreateScaffoldCommand;
// use Helpers\Commands\MigrationGeneratorCommand;
// use Phpmig\Console\Command;
// use Symfony\Component\Console\Application;

use Illuminate\Database\Capsule\Manager as Capsule;
use Phpmig\Console\Command;
use Phpmig\Api\PhpmigApplication;
use Phpmig\Adapter;


use Symfony\Component\Console\Tester\CommandTester;
use Symfony\Component\EventDispatcher\EventDispatcher;
use Firebase\JWT\JWT;




class FeatureContext implements SnippetAcceptingContext
{
    private $slimapp;
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

    public function __construct()
    {

      //  bootstrapping slim
      $settings = require __DIR__ . '/../../app/settings.php';
      // session_start();
      // $app = new \Slim\App($settings);

      // https://guzzle3.readthedocs.io/http-client/client.html

      // Set up dependencies
      // require __DIR__ . '/../../app/dependencies.php';
      //
      // // Register middleware
      // require __DIR__ . '/../../app/middleware.php';
      //
      // // Register routes
      // require __DIR__ . '/../../app/routes.php';
      // require __DIR__ . '/../../app/Routes/doctors.php';
        // $this->shelf = new App\Model\Doctor();
        // $this->basket = new Basket($this->shelf);
      // $this->slimapp = $app;

      $this->base_url = $settings['app']["url"];

      $this->client           = new GuzzleHttp\Client([
          'base_uri' => $this->base_url,

      ]);
      $this->response = new GuzzleHttp\Psr7\Response();


      //
      // follow all for migration testing
      $capsule   = new Capsule;
      $capsule->addConnection($settings['settings']['database']);
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



      // $client->setDefaultOption('headers', array('X-Foo' => 'Bar'));
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
        // var_dump($this->headers);
        // var_dump($arg1, $arg2);
        try {
          $this->response = $this->client->request($arg2, $arg1,  array("headers"=>$this->headers));
          // echo ($this->response->getBody());
         //  $client = new \GuzzleHttp\Client();
        //  echo $this->base_url.$arg1;
        //  $this->request = new \GuzzleHttp\Psr7\Request($arg2, $this->base_url.$arg1, array("headers"=>$this->headers));
        //  var_dump(get_class_methods($this->request));
        //  var_dump($this->request->getUri());
        //  var_dump($this->request->getRequestTarget());
        // echo $this->request->getStatusCode();
          // $this->response = $this->client->send($this->request);
          // echo $this->response->getStatusCode();
        } catch (GuzzleHttp\Exception\ClientException $e) {
            // echo ($e->getResponse()->getBody());
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
          // var_dump($this->response);
          //  var_dump(get_class_methods($this->response));
          $b = $this->response->getBody();
          // /$contents = $b->getContents();
//           foreach ($this->response->getHeaders() as $name => $values) {
//     echo $name . ': ' . implode(', ', $values) . "\r\n";
// }
//           $stream = $this->response->getBody();
// $contents = $stream->getContents(); // returns all the contents
// echo $contents;
// $contents = $stream->getContents(); // empty string
// echo $contents;
// $stream->rewind(); // Seek to the beginning
// $contents = $stream->getContents(); // returns all the contents
// echo $contents;
//
//           // var_dump ($b);
//           var_dump($contents);
          $a = json_decode($b, true);
          // var_dump ($a);
          // Guzzle Responses
          // var_dump ($this->response->isSuccessful()); // true
// $response->isInformational();
// $response->isRedirect();
// $response->isClientError();
// $response->isServerError();

          PHPUnit_Framework_Assert::assertNotNull($a[$arg1]);
          PHPUnit_Framework_Assert::assertEquals(count($a[$arg1]), $arg2);

          // throw new PendingException();
      }


      /**
       * @Then the response status code should be :arg1
       */
      public function theResponseStatusCodeShouldBe($arg1)
      {
         //  throw new PendingException();

          PHPUnit_Framework_Assert::assertEquals(
              intval($arg1),
               $this->response->getStatusCode()
          );
      }






    /**
     * @Given that Migration :arg1 is up
     * use MigrationName or MigrationID (Unixtime, Int)
     * for migrations run "php cli.php status" from base directory
     */
    public function thatMigrationIsUp($arg1)
    {
        $versionsUp = $this->migcontainer['phpmig.adapter']->fetchAll();
        if(is_numeric($arg1)) { // use of MigrationID
          PHPUnit_Framework_Assert::assertContains(
              $arg1,
              $versionsUp
          );
            // $this->assertContains( $randad, $adUnitArr );
        } else { // use of MigrationName

        }


        foreach($this->mig->getMigrations(0) as $migration)  {

         if (in_array($migration->getVersion(), $versionsUp)) {
              $status = "     <info>up</info> ";
              unset($versionsUp[array_search($migration->getVersion(), $versionsUp)]);
          } else {
              $status = "   <error>down</error> ";
          }

          $this->output->writeln(
              $status .
              sprintf(" %14s ", $migration->getVersion()) .
              " <comment>" . $migration->getName() . "</comment>"
          );

        }
        echo ($this->output->fetch());
        throw new PendingException();
    }






   /**
    * @When I request :arg1
    */
//    public function iRequest($arg1)
//    {
//
//      var_dump($arg1);
//     //  $res = $client->request('GET', '/redirect/3', ['allow_redirects' => false]);
// // echo $res->getStatusCode();
//       try {
//         $this->client->get('api/doctors/1');
//         var_dump($this->response->getBody());
//
//           // $this->buildRequest();
//
//       } catch(\GuzzleHttp\Exception\ClientException $e) {
//
//           $this->response = new \GuzzleHttp\Message\Response(
//               $e->getResponse()->getStatusCode(),
//               ['content-type' => $e->getResponse()->getHeader('content-type')]
//           );
//
//       }
//       // var_dump("ddddd");
//       //  throw new PendingException();
//    }









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
  public function iHaveThePayload(PyStringNode $string)
  {
     //  var_dump($string);
      $app = $this->slimapp;



     //  var_dump($this->client);
     // $request = $this->client->get('http://localhost/health/s3_1/public/api/doctor');


      $request = $this->client->get('http://localhost/health/s3_1/public/api/doctor', array(
   'headers' => array("Authorization"=>"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE0ODA1Mjc1NTksImp0aSI6IktqQT0iLCJpc3MiOiJsb2NhbGhvc3QiLCJuYmYiOjE0ODA1Mjc1NTksImV4cCI6MTU0MjczNTU1OSwiZGF0YSI6eyJoZWxsbyI6Ind1cnN0In19.Ps-pMwymWCmrKRSI2xrkYsYxXCux_XsLI0T5wEkJH4A")
 ));

     //  $response = $request->send();
     //  echo $request->getStatusCode();
     //  echo $request->getBody();
     //  var_dump($request->getBody());


     // var_dump($this->mig->getVersion());
     // $status = new Phpmig\Console\Command\StatusCommand();
     // var_dump($this->mig->getAdapter()->fetchAll());
     $versionsUp = $this->migcontainer['phpmig.adapter']->fetchAll();
     // var_dump($versionsUp);
     // var_dump(get_class_methods($this->mig));
     // var_dump($versions);
     // var_dump($this->mig->getVersion());
     // var_dump($this->mig->getMigrations("20161130201046"));
     // var_dump($this->mig->getMigrations("20151223205740"));


     foreach($this->mig->getMigrations(0) as $migration) {
         echo ($migration->getName());
         echo "\n";
         echo ($migration->getVersion());
         echo "\n";
         // var_dump ($migration->getContainer());
         echo "\n";
         echo "\n";

         if (in_array($migration->getVersion(), $versionsUp)) {
             $status = "     <info>up</info> ";
             unset($versionsUp[array_search($migration->getVersion(), $versionsUp)]);
         } else {
             $status = "   <error>down</error> ";
         }

         $this->output->writeln(
             $status .
             sprintf(" %14s ", $migration->getVersion()) .
             " <comment>" . $migration->getName() . "</comment>"
         );
     }

     echo ($this->output->fetch());
     // foreach($versions as $missing) {
     //     $output->writeln(
     //         '   <error>up</error> ' .
     //         sprintf(" %14s ", $missing) .
     //         ' <error>** MISSING **</error> '
     //     );
     // }

     // print status
     // $output->writeln("");

     // var_dump($this->mig);


     // foreach($versions as $missing) {
     //     $output->writeln(
     //         '   <error>up</error> ' .
     //         sprintf(" %14s ", $missing) .
     //         ' <error>** MISSING **</error> '
     //     );
     // }
     //
     // $output = new \Symfony\Component\Console\Output\NullOutput();
     // // // create container from bootstrap file
     // // $container = require __DIR__ . '/../../phpmig.php';
     // //
     // $mig = new PhpmigApplication($this->migcontainer, $output);
     // //
     // // // run the migrations
     //
     // $mig->status();



      try {

          // $this->buildRequest();

      } catch(\GuzzleHttp\Exception\ClientException $e) {

          $this->response = new \GuzzleHttp\Message\Response(
              $e->getResponse()->getStatusCode(),
              ['content-type' => $e->getResponse()->getHeader('content-type')]
          );

      }
     //  var_dump("ddddd");
     //  $this->requestMethod    = self::METHOD_GET;
     //  $this->resource         = $resource;
     //  var_dump($app);
     // PHPUnit_Framework_Assert::assertEquals(
     //     intval(2),
     //     1
     // );
      throw new PendingException();
  }


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
