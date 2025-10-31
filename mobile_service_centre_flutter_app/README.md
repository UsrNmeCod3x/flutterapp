# Mobile Service Centre Flutter Application

This is a Flutter mobile application that connects to the Mobile Service Centre Management System through its REST API.

## Prerequisites

1. Flutter SDK (version 2.17 or higher)
2. Dart SDK
3. Android Studio or VS Code with Flutter extensions
4. Mobile Service Centre Management System running locally or on a server

## Setup Instructions

1. Clone or download this Flutter project
2. Navigate to the project directory
3. Install dependencies:
   ```
   flutter pub get
   ```

4. Make sure the Mobile Service Centre Management System is running on `http://localhost:3000`
   (Update the `baseUrl` in `lib/services/api_service.dart` if your backend is hosted elsewhere)

5. Run the application:
   ```
   flutter run
   ```

## Features

- User authentication (Admin and Staff)
- Dashboard with overview statistics
- Customer management
- Job tracking
- Stock/inventory management
- User profile

## API Integration

The application connects to the following API endpoints:

- Authentication: `/api/v1/auth`
- Customers: `/api/v1/customers`
- Jobs: `/api/v1/jobs`
- Staff: `/api/v1/staff`
- Stock: `/api/v1/stock`

## Building for Production

To build the application for release:

### Android
```
flutter build apk
```

### iOS
```
flutter build ios
```

## Customization

You can customize the application by modifying:

1. UI components in the `lib/screens` directory
2. API service in `lib/services/api_service.dart`
3. Data models in `lib/models`
4. Application theme in `lib/main.dart`

## Troubleshooting

If you encounter connection issues:

1. Verify the backend is running
2. Check that the `baseUrl` in `api_service.dart` is correct
3. Ensure your device/emulator can access the backend server
4. Check firewall settings if needed