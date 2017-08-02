<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
  	protected $table = "user";

	protected $primaryKey = 'userID';

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
        'nameFirst',
        'nameLast',
        'academicTitle',
        'userType',
		'groupID',
	];

	public function id(){

        return $this->hasOne('App\Models\Id', 'userID', 'userID');
    }

    public function email(){
    	return $this->hasMany('App\Models\Email','userID');
    }

    public function phone(){
        return $this->hasMany('App\Models\Phone','userID');
    }
}