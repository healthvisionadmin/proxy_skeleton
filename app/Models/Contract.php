<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Contract extends Model
{
  	protected $table = "contract";

	protected $primaryKey = 'userID';

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;
    

	protected $fillable = [
        'contractStartDate',
        'contractEndDate',
        'number',
	];

	public function user(){
        return $this->belongsTo('App\Models\User','userID','userID');
    }
}