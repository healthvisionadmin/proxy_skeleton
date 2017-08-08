<?php
namespace App\Action\helpService;

use App\Action\BaseController;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use Respect\Validation\Validator as V;

class HelpServiceController extends BaseController
{

    //private $model;

    public function __construct($container)
    {
        parent::__construct($container);
    }

    public function index(Request $request, Response $response, $args)
    {
        $permalink = $args['permalink'];


        $file = PATH_ROOT . "../library/json/help_settings.json";
        $str = file_get_contents($file);
        $array = json_decode($str,true);
        $key = $array['setting']['key'];

        $url = "http://healthvision.customerdemourl.com/".$permalink."/?key=$key";

        $ch = curl_init();
        // Disable SSL verification
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        // Will return the response, if false it print the response
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        // Set the url
        curl_setopt($ch, CURLOPT_URL,$url);
        // Execute
        $result=curl_exec($ch);
        // Closing
        curl_close($ch);


        return  $response->write($result);
       
       
       
    }
}