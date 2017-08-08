<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PersonalData extends Model
{
  	protected $table = "personaldata";

	protected $primaryKey = 'userID';

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
        'sex',
        'yearBirth',
	];

	public function user(){
        return $this->belongsTo('App\Models\User','userID','userID');
    }
}