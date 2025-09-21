# GoRouter ShellRoute Demo

This Flutter web project demonstrates how to use GoRouter's `ShellRoute` for creating nested navigation with persistent UI elements.

## What is ShellRoute?

`ShellRoute` is a special type of route in GoRouter that provides a persistent UI shell around child routes. It's perfect for creating layouts with navigation bars, sidebars, or any persistent UI elements that should remain visible while navigating between different screens.

## Key Features

- **Persistent UI Elements**: Navigation bars, sidebars, headers, and footers remain visible across route changes
- **State Preservation**: Widget state is maintained when navigating between routes within the shell
- **Better Performance**: The shell UI is not rebuilt when navigating between child routes
- **Consistent Layout**: Ensures a uniform layout structure across all routes
- **Nested Navigation**: Supports complex nested navigation structures
- **URL-based Routing**: Full support for deep linking and browser navigation

## ShellRoute Properties

### 1. `builder` (Required)
```dart
builder: (context, state, child) {
  return ShellLayout(child: child);
}
```
- **Purpose**: Builds the shell UI that wraps around child routes
- **Parameters**:
  - `context`: BuildContext for the route
  - `state`: GoRouterState containing route information
  - `child`: The child route widget to be displayed
- **Returns**: The shell widget that contains the child route

### 2. `routes` (Required)
```dart
routes: [
  GoRoute(path: '/', builder: (context, state) => HomeScreen()),
  GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
  // ... more routes
]
```
- **Purpose**: Defines all child routes that will be wrapped by the shell
- **Type**: List of GoRoute objects
- **Note**: These routes will be displayed inside the shell layout

### 3. `redirect` (Optional)
```dart
redirect: (context, state) {
  // Check authentication, permissions, etc.
  if (!isAuthenticated) {
    return '/login';
  }
  return null; // No redirect needed
}
```
- **Purpose**: Redirects users based on certain conditions
- **Parameters**: `context` and `state`
- **Returns**: String path to redirect to, or null for no redirect
- **Use Cases**: Authentication checks, permission validation, maintenance mode

### 4. `onExit` (Optional)
```dart
onExit: (context, state) {
  // Cleanup, save data, show confirmation dialog, etc.
  return true; // Allow navigation
}
```
- **Purpose**: Called when navigating away from any route in the shell
- **Parameters**: `context` and `state`
- **Returns**: Boolean indicating whether navigation should proceed
- **Use Cases**: Data validation, cleanup, confirmation dialogs

## Project Structure

```
lib/
├── main.dart                 # Main app with GoRouter configuration
├── widgets/
│   └── shell_layout.dart    # Shell layout with navigation
└── screens/
    ├── home_screen.dart     # Home screen
    ├── profile_screen.dart  # Profile screen with state
    ├── settings_screen.dart # Settings screen with form
    ├── about_screen.dart    # About screen with information
    └── contact_screen.dart  # Contact screen with form
```

## How to Run

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the web app**:
   ```bash
   flutter run -d web-server --web-port 8080
   ```

3. **Open in browser**:
   Navigate to `http://localhost:8080`

## Demo Features

### 1. Responsive Navigation
- **Desktop**: Side navigation rail
- **Mobile**: Bottom navigation bar
- **Adaptive**: Automatically switches based on screen size

### 2. State Preservation
- **Profile Screen**: Login counter persists across navigation
- **Settings Screen**: Form values are maintained
- **Contact Screen**: Form data is preserved

### 3. Navigation Examples
- **Programmatic Navigation**: Using `context.go()`
- **URL-based Routing**: Direct URL access works
- **Browser Navigation**: Back/forward buttons work correctly

## Common Use Cases

### 1. Bottom Navigation Apps
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        // Navigation items
      ),
    );
  },
  routes: [
    // Tab routes
  ],
)
```

### 2. Sidebar Navigation
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(/* sidebar */),
          Expanded(child: child),
        ],
      ),
    );
  },
  routes: [
    // Main content routes
  ],
)
```

### 3. Drawer Navigation
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      drawer: Drawer(/* drawer content */),
    );
  },
  routes: [
    // Routes accessible via drawer
  ],
)
```

## Best Practices

1. **Keep Shell Simple**: The shell should only contain persistent UI elements
2. **Use State Management**: For complex state, consider using Provider, Riverpod, or Bloc
3. **Handle Responsive Design**: Make sure your shell works on different screen sizes
4. **Optimize Performance**: Avoid heavy computations in the shell builder
5. **Test Navigation**: Ensure all navigation paths work correctly
6. **Handle Deep Links**: Test direct URL access to all routes

## Troubleshooting

### Common Issues

1. **State Not Preserved**: Make sure you're using `StatefulWidget` for screens that need state
2. **Navigation Not Working**: Check that routes are properly defined in the `routes` list
3. **UI Not Responsive**: Ensure your shell layout adapts to different screen sizes
4. **Performance Issues**: Avoid rebuilding the shell unnecessarily

### Debug Tips

1. Use `GoRouter.of(context).routerDelegate.currentConfiguration` to debug route configuration
2. Check the browser's developer tools for navigation errors
3. Use `debugPrint()` to log navigation events
4. Test with different screen sizes and orientations

## Further Reading

- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Flutter Navigation Guide](https://docs.flutter.dev/development/ui/navigation)
- [Material Design Navigation](https://material.io/design/navigation/)

## License

This project is for educational purposes and demonstrates GoRouter ShellRoute functionality.