<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Fitness Tracker')</title>
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <h1 class="nav-title">Fitness Tracker</h1>
            <ul class="nav-menu">
                <li><a href="{{ route('workouts.index') }}" class="nav-link">All Workouts</a></li>
                <li><a href="{{ route('workouts.create') }}" class="nav-link">Add Workout</a></li>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <div class="container">
            @if(session('success'))
                <div class="alert alert-success">
                    {{ session('success') }}
                </div>
            @endif

            @if(isset($errors) && $errors->any())
                <div class="alert alert-error">
                    <ul>
                        @foreach($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            @yield('content')
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; {{ date('Y') }} Fitness Tracker. Track your fitness journey.</p>
        </div>
    </footer>
</body>
</html>

