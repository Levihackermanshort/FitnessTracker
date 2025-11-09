<?php

namespace App\Http\Controllers;

use App\Models\Workout;
use Illuminate\Http\Request;

class WorkoutController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Workout::query()->orderBy('date', 'desc');

        // Search functionality
        if ($request->has('search') && $request->search) {
            $search = $request->search;
            $query->where(function($q) use ($search) {
                $q->where('exercise', 'like', "%{$search}%")
                  ->orWhere('notes', 'like', "%{$search}%");
            });
        }

        // Pagination
        $workouts = $query->paginate(10)->withQueryString();

        return view('workouts.index', compact('workouts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('workouts.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'date' => 'required|date',
            'exercise' => 'required|string|max:100',
            'duration' => 'required|integer|min:1|max:600',
            'calories' => 'nullable|integer|min:0|max:10000',
            'notes' => 'nullable|string|max:1000',
        ]);

        Workout::create($validated);

        return redirect()->route('workouts.index')
            ->with('success', 'Workout created successfully!');
    }

    /**
     * Display the specified resource.
     */
    public function show(Workout $workout)
    {
        return view('workouts.show', compact('workout'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Workout $workout)
    {
        return view('workouts.edit', compact('workout'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Workout $workout)
    {
        $validated = $request->validate([
            'date' => 'required|date',
            'exercise' => 'required|string|max:100',
            'duration' => 'required|integer|min:1|max:600',
            'calories' => 'nullable|integer|min:0|max:10000',
            'notes' => 'nullable|string|max:1000',
        ]);

        $workout->update($validated);

        return redirect()->route('workouts.index')
            ->with('success', 'Workout updated successfully!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Workout $workout)
    {
        $workout->delete();

        return redirect()->route('workouts.index')
            ->with('success', 'Workout deleted successfully!');
    }
}

