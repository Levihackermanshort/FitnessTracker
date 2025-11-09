@extends('layouts.app')

@section('title', 'Edit Workout')

@section('content')
    <div class="page-header">
        <h2>Edit Workout</h2>
        <a href="{{ route('workouts.index') }}" class="btn btn-secondary">Back to Workouts</a>
    </div>

    <form action="{{ route('workouts.update', $workout) }}" method="POST" class="workout-form">
        @csrf
        @method('PUT')

        <div class="form-group">
            <label for="date">Date <span class="required">*</span></label>
            <input type="date" id="date" name="date" value="{{ old('date', $workout->date->format('Y-m-d')) }}" 
                   class="form-control @error('date') error @enderror" required>
            @error('date')
                <span class="error-message">{{ $message }}</span>
            @enderror
        </div>

        <div class="form-group">
            <label for="exercise">Exercise <span class="required">*</span></label>
            <input type="text" id="exercise" name="exercise" value="{{ old('exercise', $workout->exercise) }}" 
                   class="form-control @error('exercise') error @enderror" 
                   placeholder="e.g., Running, Weight Training, Cycling" required>
            @error('exercise')
                <span class="error-message">{{ $message }}</span>
            @enderror
        </div>

        <div class="form-group">
            <label for="duration">Duration (minutes) <span class="required">*</span></label>
            <input type="number" id="duration" name="duration" value="{{ old('duration', $workout->duration) }}" 
                   class="form-control @error('duration') error @enderror" 
                   min="1" max="600" required>
            @error('duration')
                <span class="error-message">{{ $message }}</span>
            @enderror
        </div>

        <div class="form-group">
            <label for="calories">Calories Burned</label>
            <input type="number" id="calories" name="calories" value="{{ old('calories', $workout->calories) }}" 
                   class="form-control @error('calories') error @enderror" 
                   min="0" max="10000">
            @error('calories')
                <span class="error-message">{{ $message }}</span>
            @enderror
        </div>

        <div class="form-group">
            <label for="notes">Notes</label>
            <textarea id="notes" name="notes" rows="4" 
                      class="form-control @error('notes') error @enderror" 
                      placeholder="Add any notes about your workout...">{{ old('notes', $workout->notes) }}</textarea>
            @error('notes')
                <span class="error-message">{{ $message }}</span>
            @enderror
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Update Workout</button>
            <a href="{{ route('workouts.index') }}" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
@endsection

