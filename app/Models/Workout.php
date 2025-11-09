<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Workout extends Model
{
    protected $fillable = [
        'date',
        'exercise',
        'duration',
        'calories',
        'notes',
    ];

    protected $casts = [
        'date' => 'date',
        'duration' => 'integer',
        'calories' => 'integer',
    ];
}

