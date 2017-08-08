<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pin extends Model
{
  	protected $table = "pin";

	protected $primaryKey = 'userID';

	protected $fillable = [
		'hashedSaltedPIN',
		'validUntilDateTime',
		'sendDateTime',
		'number',
	];
}