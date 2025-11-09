# Fitness Tracker

A Laravel-based web application for tracking fitness workouts and exercise activities. This application allows users to record, view, edit, and delete workout entries, providing a simple and effective way to monitor fitness progress.

## Scenario

The Fitness Tracker application is designed to help individuals maintain a comprehensive log of their daily exercise routines. Users can record various types of workouts including running, cycling, weight training, swimming, and more. Each workout entry captures essential information such as the date, exercise type, duration, calories burned, and optional notes. This application serves as a personal fitness journal, enabling users to track their progress over time and maintain motivation through consistent logging of their physical activities.

## MVC Design Pattern

This application follows the Model-View-Controller (MVC) architectural pattern, which is fundamental to Laravel's design philosophy. The MVC pattern separates the application into three distinct components, each with specific responsibilities:

### Model (app/Models/Workout.php)

The Model represents the data structure and business logic. In this application, the `Workout` model extends Laravel's Eloquent ORM, providing an elegant interface for interacting with the `workouts` database table. The model defines the fillable attributes (`date`, `exercise`, `duration`, `calories`, `notes`) and type casting for proper data handling. For example:

```php
protected $fillable = [
    'date',
    'exercise',
    'duration',
    'calories',
    'notes',
];
```

The model handles all database interactions, allowing the controller to work with workout data as objects rather than raw database queries. This abstraction simplifies data manipulation and ensures type safety through Eloquent's casting mechanisms.

### View (resources/views/)

Views are responsible for presenting data to users. This application uses Laravel's Blade templating engine, which provides powerful directives for creating dynamic HTML. The views are organized in a hierarchical structure:

- **Layout Template** (`layouts/app.blade.php`): Defines the common structure including navigation, alerts, and footer, using `@yield` and `@section` directives for content injection.

- **Resource Views** (`workouts/`): Four views handle different aspects of workout management:
  - `index.blade.php`: Displays a paginated list of all workouts with search functionality
  - `create.blade.php`: Form for adding new workout entries
  - `edit.blade.php`: Form for modifying existing workouts
  - `show.blade.php`: Detailed view of a single workout entry

Blade directives such as `@extends`, `@section`, `@foreach`, and `@if` enable dynamic content rendering while maintaining clean, readable templates. For instance, the index view uses `@foreach($workouts as $workout)` to iterate through workout records, and `{{ $workout->exercise }}` to display data safely with automatic HTML escaping.

### Controller (app/Http/Controllers/WorkoutController.php)

The Controller acts as an intermediary between the Model and View, handling HTTP requests and coordinating the application's response. The `WorkoutController` implements all CRUD operations:

- **Index**: Retrieves and displays workouts with optional search filtering and pagination
- **Create/Store**: Validates input and saves new workout entries
- **Show**: Displays detailed information about a specific workout
- **Edit/Update**: Allows modification of existing workout data
- **Destroy**: Removes workout entries from the database

The controller uses Laravel's validation rules to ensure data integrity. For example, the `store` method validates that the exercise field is required, the duration is between 1 and 600 minutes, and calories are within a reasonable range. This validation occurs server-side, providing robust data protection without relying on HTML attributes.

## Key Features

### CRUD Operations

The application provides complete Create, Read, Update, and Delete functionality for workout entries. Each operation is implemented using Laravel's resource controller pattern, which maps HTTP verbs to controller methods automatically through route definitions.

### Search Functionality

Users can search workouts by exercise name or notes using a search form on the index page. The search uses Laravel's query builder with `LIKE` clauses to find partial matches, enhancing usability by allowing quick filtering of workout history.

### Pagination

Large datasets are handled efficiently through Laravel's built-in pagination system. The index view displays 10 workouts per page, with navigation links automatically generated. Pagination preserves search parameters, ensuring a seamless user experience when navigating through filtered results.

### Input Validation

All user input is validated using Laravel's validation system. The controller defines rules for each field, including required fields, data types, and acceptable ranges. Validation errors are automatically displayed to users, providing clear feedback about what needs to be corrected.

### Database Design

The single `workouts` table follows first normal form principles, with each field containing atomic values. The table structure includes:
- Primary key (`id`)
- Date field for workout date
- Exercise name (string, max 100 characters)
- Duration in minutes (integer)
- Optional calories burned (integer)
- Optional notes (text)
- Timestamps for creation and update tracking

## Good Practices Implemented

### Code Organization

The application follows Laravel's conventions for directory structure and naming. Models use singular nouns, controllers use plural nouns with "Controller" suffix, and views are organized in folders matching controller names. This consistency improves code maintainability and makes the application easier to navigate.

### Security

Laravel's CSRF protection is automatically applied to all forms through the `@csrf` Blade directive. Input validation prevents malicious data entry, and Eloquent's parameter binding protects against SQL injection attacks. All user output is escaped using Blade's `{{ }}` syntax, preventing XSS vulnerabilities.

### User Experience

The application provides persistent navigation through a header menu, clear visual feedback through success and error messages, and intuitive form layouts. Color contrast meets accessibility standards, and the interface is designed for readability at the target resolution of 1366x768 pixels.

### Database Seeding

The `WorkoutSeeder` provides sample data for testing and demonstration purposes. This allows the application to be quickly set up with realistic workout entries, making it easier to evaluate functionality during development and assessment.

## Setup Instructions

### For Local Development

1. Install PHP 8.2+ and MySQL
2. Clone the repository
3. Copy `.env.example` to `.env` (or ensure `.env` exists with correct settings)
4. Run `composer install` to install Laravel dependencies
5. Run `php artisan key:generate` to generate application key
6. Configure MySQL: `mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"`
7. Create database: `mysql -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;"`
8. Run `php artisan migrate:fresh --seed` to create tables and seed data
9. Run `php artisan serve` to start the development server
10. Access the application at `http://localhost:8000`

### For GitHub Codespaces

The application is configured to work automatically in GitHub Codespaces:

1. Open the repository in a Codespace
2. The setup script will run automatically via `.devcontainer/devcontainer.json`
3. The application will be available on port 8080 (automatically forwarded)
4. If setup doesn't run automatically, execute: `bash setup.sh`

### Using the Setup Script

A `setup.sh` script is provided for automated setup:

```bash
bash setup.sh
```

This script will:
- Check PHP and MySQL installation
- Start MySQL service
- Configure MySQL authentication
- Create the database
- Install Composer dependencies
- Generate application key
- Run migrations and seeders
- Set proper permissions

## Environment Configuration

The application uses MySQL by default. Ensure your `.env` file contains:

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=fitness_journal_db
DB_USERNAME=root
DB_PASSWORD=
```

For Codespaces, the host may need to be `127.0.0.1` instead of `localhost`.

## Testing the Application

After setup, you can:
- View all workouts at `/workouts`
- Create new workouts at `/workouts/create`
- Search workouts using the search box
- Edit existing workouts
- Delete workouts
- Navigate through paginated results

The seeder creates 10 sample workouts for immediate testing.
