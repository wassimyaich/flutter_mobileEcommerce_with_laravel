# Ecommerce-flutter-with-laravel

This project is a cross-platform mobile application built with Flutter, connected to a Laravel backend that leverages Sanctum for secure user authentication.
Table of Contents
Languages:
  * Laravel
  * JavaScript
  * HTML
  * CSS

Frameworks:
  * Flutter

Tools:
  * Git
    
Installation
Getting Started
Features
Backend API
Contributing
License
Installation

Clone the repository:
<!-- end list -->

Bash
git clone https://github.com/wassimyaich/flutter_mobileEcommerce_with_laravel.git
Use code with caution.

Navigate to the project directory:
<!-- end list -->

Bash
cd flutter_mobileEcommerce_with_laravel
Use code with caution.

Install dependencies for both Flutter and Laravel:

Flutter: Follow the instructions at <https://docs.flutter.dev/get-started/install>.
Laravel: Run composer install and npm install within your Laravel project directory.
Configure Laravel environment variables:

Copy .env.example to .env in your Laravel project directory.
Update the .env file with your database credentials and other application-specific settings.
Getting Started

Run the Laravel backend:

Bash
cd flutter_mobileEcommerce_with_laravel
php artisan serve
Use code with caution.

Run the Flutter app:

Bash
flutter pub get
flutter run
Use code with caution.

Features


Backend API

This project uses Laravel Sanctum for user authentication.
Refer to the Laravel documentation for details on Sanctum usage: <https://laravel.com/docs/11.x/sanctum>
The API endpoints are located in the app/Http/Controllers directory of your Laravel project.
Contributing

We welcome contributions to this project! Please read the CONTRIBUTING.md file (create one if it doesn't exist) for guidelines on how to contribute.

License

## References

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
