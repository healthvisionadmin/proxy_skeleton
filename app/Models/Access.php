<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Access extends Model
{
  	protected $table = "access";

	protected $primaryKey = 'userType';

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
        'isAllowedUUIDtoUAID',
        'isAllowedUAIDtoUID',
        'isAllowedSMS',
        'isAllowedPush',
	];

	
}