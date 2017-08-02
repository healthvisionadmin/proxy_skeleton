<?php
namespace App\Action\userService;

use App\Action\BaseController;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use Respect\Validation\Validator as V;

class UserController extends BaseController
{

    private $model;

    public function __construct($container)
    {
        parent::__construct($container);
    }

    public function create(Request $request, Response $response, $args)
    {

    	//$data = $user->with('id')->get();
		//return $response->write($data);

    	$nameFirst = $request->getParam('nameFirst');
    	$nameLast = $request->getParam('nameLast');
    	$academicTitle = $request->getParam('academicTitle');
    	$userType = $request->getParam('userType');
    	$pushDeviceUUID = $request->getParam('pushDeviceUUID');
    	$sex = $request->getParam('sex');
    	$dateOfYear = $request->getParam('dateOfYear');
    	$emails = json_decode($request->getParam('email'),true);
    	$phone = $request->getParam('phone');
    	$UID = $request->getParam('UID');
    	$customerUUID = $request->getParam('customerUUID');
    	$customerDepartmentUUID = $request->getParam('customerDepartmentUUID');
    	$contractStartDate = $request->getParam('contractStartDate');
    	$contractEndDate = $request->getParam('contractEndDate');
    	$pin = $request->getParam('pin');
    	$groupID = $request->getParam('groupID');

    	$this->validator->validate($request, [
           'nameFirst' => [
                'rules' => V::notBlank(),
                'messages' => [
                    'notBlank' => 'nameFirst is required'
                ]
            ],
            'nameLast' => V::notBlank(),
		    'academicTitle' => V::notBlank(),
		    'userType' => V::notBlank(),
		    'pushDeviceUUID' => V::notBlank(),
		    //'sex' => V::notBlank(),
		    'dateOfYear' => V::notBlank(),
		    'email' => V::notBlank(),
		    'phone' => V::notBlank(),
		    'UID' => V::notBlank(),
		    'customerUUID' => V::notBlank(),
		    'customerDepartmentUUID' => V::notBlank(),
		    'contractStartDate' => V::notBlank(),
		    'contractEndDate' => V::notBlank(),
		    'pin' => V::notBlank(),
		    'groupID' => V::notBlank(),
            
        ]);

        if ($this->validator->isValid()) {
           
        	/* Save data in users table */
	    	$user = $this->container->get('Model\User');

	    	$user->nameFirst       =  $nameFirst;
	    	$user->nameLast        =  $nameLast;
	    	$user->academicTitle   =  $academicTitle;
	    	$user->userType        =  $userType;
	    	$user->pushDeviceUUID  =  $pushDeviceUUID;
	    	$user->groupID         =  $groupID;

	    	$user->save();

	    	//print_r($user);die;

	    	/* Save data in id table */
	    	$id = $this->container->get('Model\Id');
	    	$id = $id->firstOrNew(['userID' => $user->userID ]);

	    	$id->userID                  =   $user->userID;
	    	$id->UID                     =   $UID;
	    	$id->pushDeviceUUID          =   $pushDeviceUUID;
	    	$id->customerUUID            =   $customerUUID;
	    	$id->customerDepartmentUUID  =   $customerDepartmentUUID;

	    	$status= $id->save();

	    	/* Insert user emails into email table */

	    	$Email = $this->container->get('Model\Email');

	    	if(is_array($emails)){

	    		$data = array();

				foreach ($emails as $email) {

					$data[] =  array('userID' => $user->userID,'address' => $email['email'],'number' => $email['id']);
				}


	    	}



	    	$Email->insert($data);

	    	
	    	$this->data['uid'] = $id->UID;

           	return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    
       
    }
}