<?php
namespace App\Action\appService;

use App\Action\BaseController;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use Respect\Validation\Validator as V;

use App\Models\Image;

class ImageServiceController extends BaseController
{

   
    public function __construct($container)
    {
        parent::__construct($container);
    }

    public function getImageById(Request $request, Response $response, $args)
    {

    	$this->validator->validate($request, [
           'image_id' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'Image Id is required'
                ]
            ],
            
        ]);

        if ($this->validator->isValid()) {

        	$image_id = $request->getParam('image_id');
           
        	/* Image table model instance */
            //$Image = $this->container->get('Model\Image');
	    	$Image = Image::where('imageID', $image_id)->first();

          
	    	$path = PATH_ROOT . "../library/image/upload/". $Image->path;
            $type = pathinfo($path, PATHINFO_EXTENSION);
            $file = file_get_contents($path);

           	return $response->withHeader('Content-Type', 'image/'.$type)->write($file);
        }

        return $this->validationErrors($response);

    
       
    }
}