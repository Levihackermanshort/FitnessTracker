@extends('layouts.app')

@section('title', 'All Workouts')

@section('content')
    <div class="page-header">
        <h2>My Workouts</h2>
        <a href="{{ route('workouts.create') }}" class="btn btn-primary">Add New Workout</a>
    </div>

    <div class="search-box">
        <form method="GET" action="{{ route('workouts.index') }}" class="search-form">
            <input type="text" name="search" placeholder="Search by exercise or notes..." 
                   value="{{ request('search') }}" class="search-input">
            <button type="submit" class="btn btn-secondary">Search</button>
            @if(request('search'))
                <a href="{{ route('workouts.index') }}" class="btn btn-link">Clear</a>
            @endif
        </form>
    </div>

    @if($workouts->count() > 0)
        <div class="workouts-table">
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Exercise</th>
                        <th>Duration (min)</th>
                        <th>Calories</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($workouts as $workout)
                        <tr>
                            <td>{{ $workout->date->format('M d, Y') }}</td>
                            <td>{{ $workout->exercise }}</td>
                            <td>{{ $workout->duration }}</td>
                            <td>{{ $workout->calories ?? 'N/A' }}</td>
                            <td class="actions">
                                <a href="{{ route('workouts.show', $workout) }}" class="btn btn-sm btn-info">View</a>
                                <a href="{{ route('workouts.edit', $workout) }}" class="btn btn-sm btn-warning">Edit</a>
                                <form action="{{ route('workouts.destroy', $workout) }}" method="POST" class="inline-form">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        <div class="pagination">
            {{ $workouts->links() }}
        </div>
    @else
        <div class="empty-state">
            <p>No workouts found. <a href="{{ route('workouts.create') }}">Create your first workout!</a></p>
        </div>
    @endif
@endsection

