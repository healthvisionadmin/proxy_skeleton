<?php
namespace App\Action\userService;

use App\Action\BaseController;
use App\Models\User;
use App\Models\Id;
use App\Models\Email;
use App\Models\PersonalData;
use App\Models\Contract;

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
	    	$user = new User();

	    	$user->nameFirst       =  $nameFirst;
	    	$user->nameLast        =  $nameLast;
	    	$user->academicTitle   =  $academicTitle;
	    	$user->userType        =  $userType;
	    	$user->pushDeviceUUID  =  $pushDeviceUUID;
	    	$user->groupID         =  $groupID;

	    	$getUniqueSlat = $this->bin_hex(12);

	    	$user->salt            =  $getUniqueSlat;
	    	$user->isBlocked       =  0;
	    	$user->isAllowedSMS    =  1;
	    	$user->isAllowedPush   =  1;

	    	$user->save();

	    	//print_r($user);die;

	    	/* Save data in id table */
	    	$id = new Id();
	    	$id = $id->firstOrNew(['userID' => $user->userID ]);

	    	$id->userID                  =   $user->userID;
	    	$id->UID                     =   $UID;
	    	$id->pushDeviceUUID          =   $pushDeviceUUID;
	    	$id->customerUUID            =   $customerUUID;
	    	$id->customerDepartmentUUID  =   $customerDepartmentUUID;

	    	$status= $id->save();

	    	/* Insert user PersonalData in personaldata table*/

	    	
	    	$PersonalData = PersonalData::firstOrNew(['userID' => $user->userID ]);

	    	$PersonalData->sex               =   $sex;
	    	$PersonalData->yearBirth         =   $dateOfYear;
	    	$PersonalData->userID            =   $user->userID;
	    	$PersonalData->save();


	    	/* Insert user Contract in contract table*/

	    	
	    	$Contract = Contract::firstOrNew(['userID' => $user->userID ]);

	    	$Contract->contractStartDate    =   $contractStartDate;
	    	$Contract->contractEndDate      =   $contractEndDate;
	    	$Contract->number               =   0;
	    	$Contract->save();


	    	/* Insert user emails into email table */

	    	$Email = new Email();

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

    /* update user records */

    public function update(Request $request, Response $response, $args)
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
    	$contractStartDate = $request->getParam('contractStartDate');
    	$contractEndDate = $request->getParam('contractEndDate');
    	$UID = $request->getParam('uid');
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
		    'contractStartDate' => V::notBlank(),
		    'contractEndDate' => V::notBlank(),
		    'uid' => V::notBlank(),
		    'groupID' => V::notBlank(),
            
        ]);

        if ($this->validator->isValid()) {

        	/* get userId from UID */

        	$Id = Id::where('UID', $UID)->first();

           
        	/* Save data in users table */
	    	$user = User::find($Id->userID);

	    	$user->nameFirst       =  $nameFirst;
	    	$user->nameLast        =  $nameLast;
	    	$user->academicTitle   =  $academicTitle;
	    	$user->userType        =  $userType;
	    	$user->pushDeviceUUID  =  $pushDeviceUUID;
	    	$user->groupID         =  $groupID;

	    	$user->save();

	    	//print_r($user);die;

	    	/* Save data in id table */
	    	
	    	$id = Id::firstOrNew(['userID' => $user->userID ]);

	    	$id->UAID                    =   $this->generate_uaidd();
	    	$id->pushDeviceUUID          =   $pushDeviceUUID;


	    	/* update data in personaldata table */

	    	$PersonalData = PersonalData::firstOrNew(['userID' => $user->userID ]);

	    	$PersonalData->sex               =   $sex;
	    	$PersonalData->yearBirth         =   $dateOfYear;
	    	$PersonalData->save();

	    	/* Insert user Contract in contract table*/

	    	
	    	$Contract = Contract::firstOrNew(['userID' => $user->userID ]);

	    	$Contract->contractStartDate    =   $contractStartDate;
	    	$Contract->contractEndDate      =   $contractEndDate;
	    	$Contract->number               =   0;
	    	$Contract->save();

	    	$status= $user->id()->save($id);

	    	


	    	
	    	$this->data['uid'] = $id->UID;

           	return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);

    
       
    }

     /* delete user records */

    public function delete(Request $request, Response $response, $args)
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

        	/* get userId from UID */

        	$Id = Id::where('UID', $uid)->first();

        	$deletedRows = User::where('userID', $Id->userID)->delete();
        	$deletedRows = Email::where('userID', $Id->userID)->delete();
        	$deletedRows = Id::where('userID', $Id->userID)->delete();

        	$this->data['uid'] = $deletedRows;

           	return $this->ok($response, $this->data, 200);
        }

        return $this->validationErrors($response);


    }

    private function bin_hex($length) {
		$random = openssl_random_pseudo_bytes($length);
		$random_bin2hex = bin2hex($random);
		return substr($random_bin2hex,$length);
	}

	private function generate_uaidd(){
		$uaid_format=array(8,4,4,4,12);
		foreach ($uaid_format as $val) {
			$uaid_keys[]= $this->bin_hex($val);
		}
		return $uaidd = implode('-', $uaid_keys);
	}


}