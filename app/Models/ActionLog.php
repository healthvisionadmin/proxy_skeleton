<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Contract extends Model
{
  	protected $table = "actionlog";

	//protected $primaryKey = 'userID';

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
        'timestamp',
        'actionType',
        'actionDescription',
        'IP',
        'GEOLocation',
        'userID',
	];

	public function user(){
        return $this->belongsTo('App\Models\User','userID','userID');
    }
}