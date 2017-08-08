<?php
namespace App\Action\appService;

use App\Action\BaseController;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use Respect\Validation\Validator as V;

class FontServiceController extends BaseController
{

    //private $model;

    public function __construct($container)
    {
        parent::__construct($container);
    }

    public function getFonts(Request $request, Response $response, $args)
    {

        $directory = PATH_ROOT . "../library/font";

        /*foreach(glob($directory.'/*.*') as $file) {
            print_r($file);
        }*/

        $files = array();

        foreach (new \DirectoryIterator($directory) as $file) {
            if ($file->isFile()) {
                $files[] = $file->getFilename();
            }
        }

        $this->data['files'] = $files;


        return $this->ok($response, $this->data, 200);
       
       
       
    }
}