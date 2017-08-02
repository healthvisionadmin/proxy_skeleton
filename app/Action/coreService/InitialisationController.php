<?php
namespace App\Action\coreService;

use App\Action\BaseController;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use Respect\Validation\Validator as V;

class InitialisationController extends BaseController
{

    private $model;

    public function __construct($container)
    {
        parent::__construct($container);
    }

    public function getSalt(Request $request, Response $response, $args)
    {

    	$this->validator->validate($request, [
           'email' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'Email is required'
                ]
            ],
            
        ]);

        if ($this->validator->isValid()) {

        	$email = $request->getParam('email');
           
        	/* Email table model instance */
	    	$Email = $this->container->get('Model\Email');

            $Email = $Email->where('address', $email)->with('user')->first();

            $this->data['salt'] = $Email->user->salt;

	    	

           	return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    
       
    }
}