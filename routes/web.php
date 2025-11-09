<?php

use App\Http\Controllers\WorkoutController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return redirect()->route('workouts.index');
});

Route::resource('workouts', WorkoutController::class);

