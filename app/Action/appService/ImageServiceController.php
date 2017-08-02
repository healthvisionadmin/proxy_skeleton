<?php
namespace App\Action\appService;

use App\Action\BaseController;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use Respect\Validation\Validator as V;

class ImageServiceController extends BaseController
{

    private $model;

    public function __construct($container)
    {
        parent::__construct($container);
    }

    public function getImage(Request $request, Response $response, $args)
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
	    	$Image = $this->container->get('Model\Image');

	    	

           	return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    
       
    }
}