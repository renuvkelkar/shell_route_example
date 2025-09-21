# ShellRoute NavigatorKey for State Preservation

## Overview

The `navigatorKey` property in GoRouter's `ShellRoute` is the proper way to preserve state across navigation within shell routes. This property creates a separate, nested navigator for the shell's child routes, which maintains the navigation stack and widget state independently.

## How NavigatorKey Works

### What is NavigatorKey?

`navigatorKey` is a `GlobalKey<NavigatorState>` that allows you to create a separate, nested navigator for the shell's child routes. This is crucial for preserving the navigation state of each child route independently.

### Key Benefits:

1. **State Preservation**: Widget state is maintained when navigating between routes within the shell
2. **Navigation Stack Management**: Each shell maintains its own navigation stack
3. **Scroll Position Preservation**: List scroll positions are remembered
4. **Form State Preservation**: Form data is maintained across navigation
5. **Independent Navigation**: Each shell can have its own navigation history

## Implementation

### Basic Setup

```dart
// Create navigator keys for each shell level
final GlobalKey<NavigatorState> _mainShellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _nestedShellNavigatorKey = GlobalKey<NavigatorState>();

// Use in ShellRoute configuration
ShellRoute(
  navigatorKey: _mainShellNavigatorKey,
  builder: (context, state, child) {
    return MainShellLayout(child: child);
  },
  routes: [
    // Main routes
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    
    // Nested ShellRoute
    ShellRoute(
      navigatorKey: _nestedShellNavigatorKey,
      builder: (context, state, child) {
        return NestedShellLayout(child: child);
      },
      routes: [
        // Nested routes
        GoRoute(path: '/nested', builder: (context, state) => NestedDashboardScreen()),
        GoRoute(path: '/nested/analytics', builder: (context, state) => NestedAnalyticsScreen()),
      ],
    ),
  ],
)
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ShellRoute NavigatorKey Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// Navigator keys for state preservation
final GlobalKey<NavigatorState> _mainShellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _nestedShellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _mainShellNavigatorKey,
      builder: (context, state, child) {
        return MainShellLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        ShellRoute(
          navigatorKey: _nestedShellNavigatorKey,
          builder: (context, state, child) {
            return NestedShellLayout(child: child);
          },
          routes: [
            GoRoute(
              path: '/nested',
              name: 'nested',
              builder: (context, state) => const NestedDashboardScreen(),
            ),
            GoRoute(
              path: '/nested/analytics',
              name: 'nested-analytics',
              builder: (context, state) => const NestedAnalyticsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
```

## State Preservation Examples

### 1. Profile Screen with Counter

```dart
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _loginCount = 42; // This will be preserved!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Login Count: $_loginCount'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _loginCount++; // State is preserved when navigating away and back
              });
            },
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}
```

### 2. Settings Screen with Form State

```dart
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value; // Preserved!
              });
            },
          ),
          DropdownButton<String>(
            value: _selectedLanguage,
            items: const [
              DropdownMenuItem(value: 'English', child: Text('English')),
              DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!; // Preserved!
              });
            },
          ),
          Slider(
            value: _fontSize,
            min: 12.0,
            max: 24.0,
            onChanged: (value) {
              setState(() {
                _fontSize = value; // Preserved!
              });
            },
          ),
        ],
      ),
    );
  }
}
```

### 3. Contact Form with Text Controllers

```dart
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController, // Text is preserved!
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _emailController, // Text is preserved!
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _messageController, // Text is preserved!
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Advanced Usage

### 1. Multiple Shell Levels

```dart
// Main shell
final GlobalKey<NavigatorState> _mainShellKey = GlobalKey<NavigatorState>();

// Admin shell within main shell
final GlobalKey<NavigatorState> _adminShellKey = GlobalKey<NavigatorState>();

// User shell within main shell
final GlobalKey<NavigatorState> _userShellKey = GlobalKey<NavigatorState>();

ShellRoute(
  navigatorKey: _mainShellKey,
  builder: (context, state, child) => MainLayout(child: child),
  routes: [
    // Admin section
    ShellRoute(
      navigatorKey: _adminShellKey,
      builder: (context, state, child) => AdminLayout(child: child),
      routes: [
        GoRoute(path: '/admin', builder: (context, state) => AdminDashboard()),
        GoRoute(path: '/admin/users', builder: (context, state) => AdminUsers()),
      ],
    ),
    // User section
    ShellRoute(
      navigatorKey: _userShellKey,
      builder: (context, state, child) => UserLayout(child: child),
      routes: [
        GoRoute(path: '/user', builder: (context, state) => UserDashboard()),
        GoRoute(path: '/user/profile', builder: (context, state) => UserProfile()),
      ],
    ),
  ],
)
```

### 2. Conditional Shells

```dart
ShellRoute(
  navigatorKey: _mainShellKey,
  builder: (context, state, child) {
    final user = AuthService.currentUser;
    
    if (user?.isAdmin == true) {
      return AdminShellLayout(child: child);
    } else {
      return UserShellLayout(child: child);
    }
  },
  routes: [
    // Routes that work for both admin and user
  ],
)
```

### 3. Dynamic Navigator Keys

```dart
class AppState extends ChangeNotifier {
  final Map<String, GlobalKey<NavigatorState>> _shellKeys = {};
  
  GlobalKey<NavigatorState> getShellKey(String shellId) {
    _shellKeys[shellId] ??= GlobalKey<NavigatorState>();
    return _shellKeys[shellId]!;
  }
}

// Usage
ShellRoute(
  navigatorKey: appState.getShellKey('main'),
  builder: (context, state, child) => MainLayout(child: child),
  routes: [
    // Routes
  ],
)
```

## Best Practices

### 1. Use Unique Keys

```dart
// Good - unique keys
final GlobalKey<NavigatorState> _mainShellKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _nestedShellKey = GlobalKey<NavigatorState>();

// Avoid - same key for different shells
final GlobalKey<NavigatorState> _sharedKey = GlobalKey<NavigatorState>();
```

### 2. Manage Key Lifecycle

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GlobalKey<NavigatorState> _mainShellKey;
  late final GlobalKey<NavigatorState> _nestedShellKey;

  @override
  void initState() {
    super.initState();
    _mainShellKey = GlobalKey<NavigatorState>();
    _nestedShellKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          ShellRoute(
            navigatorKey: _mainShellKey,
            // ... configuration
          ),
        ],
      ),
    );
  }
}
```

### 3. Test State Preservation

```dart
testWidgets('state is preserved with navigatorKey', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Navigate to profile screen
  await tester.tap(find.text('Profile'));
  await tester.pumpAndSettle();
  
  // Increment counter
  await tester.tap(find.text('Increment'));
  await tester.pumpAndSettle();
  
  // Navigate away
  await tester.tap(find.text('Home'));
  await tester.pumpAndSettle();
  
  // Navigate back to profile
  await tester.tap(find.text('Profile'));
  await tester.pumpAndSettle();
  
  // Verify state is preserved
  expect(find.text('Login Count: 43'), findsOneWidget);
});
```

## Common Issues and Solutions

### 1. State Not Preserved

**Problem**: State is lost when navigating between routes
**Solution**: Ensure you're using `navigatorKey` in your ShellRoute configuration

### 2. Multiple Shells Interfering

**Problem**: State from one shell affects another
**Solution**: Use separate `GlobalKey<NavigatorState>` instances for each shell

### 3. Memory Leaks

**Problem**: Navigator keys not properly disposed
**Solution**: Manage key lifecycle properly and dispose when no longer needed

### 4. Navigation Stack Issues

**Problem**: Unexpected navigation behavior
**Solution**: Ensure each shell has its own navigator key and proper route configuration

## Performance Considerations

### 1. Memory Usage

- Each navigator key creates a separate navigation stack
- More shells = more memory usage
- Consider the trade-off between state preservation and memory usage

### 2. Widget Rebuilds

- Navigator keys prevent unnecessary widget rebuilds
- State changes only affect the specific shell
- Better performance than global state management for navigation

### 3. Navigation Performance

- Each shell maintains its own navigation history
- Faster navigation within shells
- Slower initial navigation between shells

## Conclusion

The `navigatorKey` property is the proper and recommended way to preserve state in GoRouter's ShellRoute. It provides:

- **Automatic State Preservation**: No need for external state management
- **Navigation Stack Management**: Each shell maintains its own history
- **Performance Benefits**: Prevents unnecessary rebuilds
- **Clean Architecture**: Follows Flutter's navigation patterns

By using `navigatorKey`, you can create complex navigation structures with proper state preservation, making your app more user-friendly and performant.

## Testing the Implementation

1. **Run the app**:
   ```bash
   flutter run -d web-server --web-port 8080
   ```

2. **Test state preservation**:
   - Navigate to Profile screen and increment the counter
   - Navigate to Settings and change some settings
   - Navigate to Contact and fill out the form
   - Navigate away and back - state should be preserved!

3. **Test nested navigation**:
   - Go to nested navigation
   - Change settings in nested screens
   - Navigate between nested screens
   - Return to main navigation and back - state should be preserved!

The `navigatorKey` approach provides the most reliable and performant way to preserve state in ShellRoute implementations.
