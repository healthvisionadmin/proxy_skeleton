<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Id extends Model
{
  	protected $table = "id";

	protected $primaryKey = 'userID';

	/**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
		'UID',
		'userID',
		'UAID',
		'soaID',
		'customerDepartmentUUID',
		'customerUUID',
		'pushDeviceUUID',
		'publicKey',
	];

	public function user(){
    	return $this->belongsTo('App\Models\User','userID','userID');
    }
}