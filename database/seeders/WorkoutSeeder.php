<?php

namespace Database\Seeders;

use App\Models\Workout;
use Illuminate\Database\Seeder;

class WorkoutSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $workouts = [
            [
                'date' => now()->subDays(5)->format('Y-m-d'),
                'exercise' => 'Running',
                'duration' => 30,
                'calories' => 300,
                'notes' => 'Morning run in the park. Felt great!',
            ],
            [
                'date' => now()->subDays(4)->format('Y-m-d'),
                'exercise' => 'Weight Training',
                'duration' => 45,
                'calories' => 250,
                'notes' => 'Upper body workout. Focused on chest and shoulders.',
            ],
            [
                'date' => now()->subDays(3)->format('Y-m-d'),
                'exercise' => 'Cycling',
                'duration' => 60,
                'calories' => 450,
                'notes' => 'Long bike ride through the countryside.',
            ],
            [
                'date' => now()->subDays(2)->format('Y-m-d'),
                'exercise' => 'Swimming',
                'duration' => 40,
                'calories' => 350,
                'notes' => 'Swam 50 laps. Good cardio session.',
            ],
            [
                'date' => now()->subDays(1)->format('Y-m-d'),
                'exercise' => 'Yoga',
                'duration' => 60,
                'calories' => 150,
                'notes' => 'Restorative yoga session. Very relaxing.',
            ],
            [
                'date' => now()->format('Y-m-d'),
                'exercise' => 'HIIT',
                'duration' => 25,
                'calories' => 400,
                'notes' => 'High intensity interval training. Very challenging!',
            ],
            [
                'date' => now()->subDays(6)->format('Y-m-d'),
                'exercise' => 'Walking',
                'duration' => 45,
                'calories' => 200,
                'notes' => 'Evening walk with the dog.',
            ],
            [
                'date' => now()->subDays(7)->format('Y-m-d'),
                'exercise' => 'Pilates',
                'duration' => 50,
                'calories' => 180,
                'notes' => 'Core strengthening session.',
            ],
            [
                'date' => now()->subDays(8)->format('Y-m-d'),
                'exercise' => 'Running',
                'duration' => 35,
                'calories' => 350,
                'notes' => '5K run. Personal best time!',
            ],
            [
                'date' => now()->subDays(9)->format('Y-m-d'),
                'exercise' => 'Weight Training',
                'duration' => 50,
                'calories' => 280,
                'notes' => 'Leg day. Squats and deadlifts.',
            ],
        ];

        foreach ($workouts as $workout) {
            Workout::create($workout);
        }
    }
}

