@extends('layouts.app')

@section('title', 'Workout Details')

@section('content')
    <div class="page-header">
        <h2>Workout Details</h2>
        <div class="header-actions">
            <a href="{{ route('workouts.edit', $workout) }}" class="btn btn-warning">Edit</a>
            <a href="{{ route('workouts.index') }}" class="btn btn-secondary">Back to Workouts</a>
        </div>
    </div>

    <div class="workout-details">
        <div class="detail-card">
            <div class="detail-row">
                <span class="detail-label">Date:</span>
                <span class="detail-value">{{ $workout->date->format('l, F d, Y') }}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Exercise:</span>
                <span class="detail-value">{{ $workout->exercise }}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Duration:</span>
                <span class="detail-value">{{ $workout->duration }} minutes</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Calories Burned:</span>
                <span class="detail-value">{{ $workout->calories ?? 'Not recorded' }}</span>
            </div>
            @if($workout->notes)
                <div class="detail-row">
                    <span class="detail-label">Notes:</span>
                    <span class="detail-value">{{ $workout->notes }}</span>
                </div>
            @endif
            <div class="detail-row">
                <span class="detail-label">Created:</span>
                <span class="detail-value">{{ $workout->created_at->format('M d, Y g:i A') }}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Last Updated:</span>
                <span class="detail-value">{{ $workout->updated_at->format('M d, Y g:i A') }}</span>
            </div>
        </div>

        <div class="detail-actions">
            <form action="{{ route('workouts.destroy', $workout) }}" method="POST" class="inline-form">
                @csrf
                @method('DELETE')
                <button type="submit" class="btn btn-danger">Delete Workout</button>
            </form>
        </div>
    </div>
@endsection

