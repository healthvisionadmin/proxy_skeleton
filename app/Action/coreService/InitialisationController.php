<?php
namespace App\Action\coreService;

use App\Action\BaseController;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use Respect\Validation\Validator as V;

use App\Models\Email;
use App\Models\Id;

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
	    	

            $Email = Email::where('address', $email)->with('user')->first();

            $this->data['salt'] = $Email->user->salt;

	    	

           	return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    
       
    }

    /* verify user email and hashed pin */


    public function verifyPin(Request $request, Response $response, $args)
    {

        $this->validator->validate($request, [
           'email' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'Email is required'
                ]
            ],

            'hashedPin' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'hashedPin is required'
                ]
            ],
            
        ]);

        if ($this->validator->isValid()) {

            $responseData = [];

            $email = $request->getParam('email');
            $hashedPin = $request->getParam('hashedPin');
           
           
            $user =Email::where('address', $email);
            $user->WhereHas('user', function($query) use($hashedPin){ $query->where('salt', "{$hashedPin}");});
            $user->with('id');

            $getUser =  $user->first()->toArray();

           //echo "<pre>" .print_r($getUser['id']['UID']);die;

           $responseData['UID'] = $getUser['id']['UID'];
           $responseData['publicKey'] = $getUser['id']['publicKey'];

           $this->data['responseData'] = $responseData;

           return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    
       
    }


    /* validate UID and Return UAID to clent by get UID*/

     public function getUaidByUid(Request $request, Response $response, $args)
    {

         $this->validator->validate($request, [
           'uid' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'uid is required'
                ]
            ],

            
        ]);

        if ($this->validator->isValid()) {

            $uid = $request->getParam('uid');
    
           
            $Id =Id::where('uid', $uid)->first();
           //echo "<pre>" .print_r($getUser['id']['UID']);die;

           $this->data['UAID'] = $Id->UAID;

           return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    }

    /* Return Public key To client by get UID */

    public function getPublicKeyByUid(Request $request, Response $response, $args)
    {

         $this->validator->validate($request, [
           'uid' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'uid is required'
                ]
            ],

            
        ]);

        if ($this->validator->isValid()) {

            $uid = $request->getParam('uid');
    
           
            $Id =Id::where('uid', $uid)->first();
           //echo "<pre>" .print_r($getUser['id']['UID']);die;

           $this->data['publicKey'] = $Id->publicKey;

           return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    }


   /* Return Public key To client by get UUID */

    public function getPublicKeyByUUID(Request $request, Response $response, $args)
    {

         $this->validator->validate($request, [
           'uuid' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'uuid is required'
                ]
            ],

            
        ]);

        if ($this->validator->isValid()) {

            $uuid = $request->getParam('uuid');
    
           
            $Id =Id::where('customerUUID', $uuid)->first();
           //echo "<pre>" .print_r($getUser['id']['UID']);die;

           $this->data['publicKey'] = $Id->publicKey;

           return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    }



}