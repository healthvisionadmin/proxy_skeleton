<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Email extends Model
{
  	protected $table = "email";

	protected $primaryKey = 'userID';

	/**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
		'userID',
		'address',
		'number',
		'note',
	];

	public function user(){
    	return $this->belongsTo('App\Models\User','userID','userID');
    }
}