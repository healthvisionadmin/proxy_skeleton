<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Phone extends Model
{
  	protected $table = "phone";

	protected $primaryKey = 'userID';

	/**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
		'phone',
		'userID',
		'note',
		'number',
	];

	public function user(){
    	return $this->belongsTo('App\Models\User','userID','userID');
    }
}