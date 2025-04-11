# 🎬 Movie DB App

A Flutter application that shows popular movies and movie details using the TMDB API.

## Architecture

This app follows a **simple MVVM-inspired architecture**. Cubits act as ViewModels, separating UI from logic, while services handle API calls.

- `Cubit` from `flutter_bloc` for state management
- `Dio` for API communication
- `get_it` and `injectable` for dependency injection 

## Run the App

```bash
flutter pub get
flutter run