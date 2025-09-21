# GoRouter ShellRoute Complete Guide

## Table of Contents
1. [Introduction](#introduction)
2. [ShellRoute Properties](#shellroute-properties)
3. [Implementation Examples](#implementation-examples)
4. [Advanced Features](#advanced-features)
5. [Best Practices](#best-practices)
6. [Common Patterns](#common-patterns)
7. [Troubleshooting](#troubleshooting)

## Introduction

`ShellRoute` is a powerful feature in GoRouter that allows you to create persistent UI shells around your routes. Unlike regular routes that completely replace the previous screen, ShellRoute maintains a consistent layout structure while only changing the content area.

### Key Benefits:
- **Persistent Navigation**: Navigation bars, sidebars, and other UI elements remain visible
- **State Preservation**: Widget state is maintained across route changes
- **Performance**: Shell UI is not rebuilt when navigating between child routes
- **Consistent UX**: Users always know where they are in the app
- **Deep Linking**: Full URL support for all routes within the shell

## ShellRoute Properties

### 1. `builder` (Required)
The most important property that defines how the shell UI is constructed.

```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Row(
        children: [
          NavigationRail(/* sidebar */),
          Expanded(child: child), // This is where child routes are displayed
        ],
      ),
    );
  },
  routes: [/* child routes */],
)
```

**Parameters:**
- `context`: BuildContext for the route
- `state`: GoRouterState containing current route information
- `child`: The child route widget to be displayed

**Key Points:**
- The `child` parameter is where your child routes will be rendered
- This function is called once when the shell is created
- The shell UI remains persistent across route changes

### 2. `routes` (Required)
Defines all child routes that will be wrapped by the shell.

```dart
ShellRoute(
  builder: (context, state, child) => ShellLayout(child: child),
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => ProfileScreen(),
    ),
    // Nested shell routes are also possible
    ShellRoute(
      builder: (context, state, child) => NestedShell(child: child),
      routes: [
        GoRoute(
          path: '/settings/general',
          builder: (context, state) => GeneralSettingsScreen(),
        ),
        GoRoute(
          path: '/settings/privacy',
          builder: (context, state) => PrivacySettingsScreen(),
        ),
      ],
    ),
  ],
)
```

**Key Points:**
- All routes in this list will be wrapped by the shell
- Routes can be nested (ShellRoute within ShellRoute)
- Each route can have its own path, name, and builder

### 3. `redirect` (Optional)
Allows you to redirect users based on certain conditions.

```dart
ShellRoute(
  builder: (context, state, child) => ShellLayout(child: child),
  redirect: (context, state) {
    // Check if user is authenticated
    if (!AuthService.isAuthenticated) {
      return '/login';
    }
    
    // Check if user has required permissions
    if (state.uri.path.startsWith('/admin') && !AuthService.isAdmin) {
      return '/unauthorized';
    }
    
    // Check if app is in maintenance mode
    if (AppConfig.isMaintenanceMode) {
      return '/maintenance';
    }
    
    return null; // No redirect needed
  },
  routes: [/* child routes */],
)
```

**Use Cases:**
- Authentication checks
- Permission validation
- Maintenance mode
- Feature flags
- A/B testing

**Return Values:**
- `String`: Path to redirect to
- `null`: No redirect needed
- `false`: Cancel navigation (rarely used)

### 4. `onExit` (Optional)
Called when navigating away from any route in the shell.

```dart
ShellRoute(
  builder: (context, state, child) => ShellLayout(child: child),
  onExit: (context, state) async {
    // Show confirmation dialog
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Unsaved Changes'),
        content: Text('You have unsaved changes. Are you sure you want to leave?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Leave'),
          ),
        ],
      ),
    );
    
    return shouldExit ?? false;
  },
  routes: [/* child routes */],
)
```

**Use Cases:**
- Data validation before leaving
- Confirmation dialogs
- Cleanup operations
- Auto-save functionality

**Return Values:**
- `true`: Allow navigation to proceed
- `false`: Cancel navigation
- `Future<bool>`: For async operations

## Implementation Examples

### 1. Basic Bottom Navigation
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(state.uri.path),
        onTap: (index) => _onTabTapped(context, index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
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
          NavigationRail(
            selectedIndex: _getSelectedIndex(state.uri.path),
            onDestinationSelected: (index) => _onDestinationSelected(context, index),
            destinations: [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  },
  routes: [/* child routes */],
)
```

### 3. Drawer Navigation
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('My App')),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => context.go('/'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => context.go('/profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => context.go('/settings'),
            ),
          ],
        ),
      ),
    );
  },
  routes: [/* child routes */],
)
```

### 4. Responsive Navigation
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      // Show different navigation based on screen size
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? BottomNavigationBar(/* mobile navigation */)
          : null,
      drawer: MediaQuery.of(context).size.width < 600
          ? Drawer(/* mobile drawer */)
          : null,
      // Desktop sidebar
      body: MediaQuery.of(context).size.width >= 600
          ? Row(
              children: [
                NavigationRail(/* desktop sidebar */),
                Expanded(child: child),
              ],
            )
          : child,
    );
  },
  routes: [/* child routes */],
)
```

## Advanced Features

### 1. Nested Shell Routes
You can nest ShellRoute within ShellRoute for complex navigation structures.

```dart
ShellRoute(
  builder: (context, state, child) => MainShell(child: child),
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    // Nested shell for settings
    ShellRoute(
      builder: (context, state, child) => SettingsShell(child: child),
      routes: [
        GoRoute(path: '/settings', builder: (context, state) => SettingsHomeScreen()),
        GoRoute(path: '/settings/general', builder: (context, state) => GeneralSettingsScreen()),
        GoRoute(path: '/settings/privacy', builder: (context, state) => PrivacySettingsScreen()),
      ],
    ),
  ],
)
```

### 2. Conditional Shells
You can conditionally show different shells based on user state or other conditions.

```dart
ShellRoute(
  builder: (context, state, child) {
    final user = AuthService.currentUser;
    
    if (user == null) {
      return GuestShell(child: child);
    } else if (user.isAdmin) {
      return AdminShell(child: child);
    } else {
      return UserShell(child: child);
    }
  },
  routes: [/* child routes */],
)
```

### 3. Dynamic Route Generation
You can dynamically generate routes based on data.

```dart
ShellRoute(
  builder: (context, state, child) => ShellLayout(child: child),
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    // Generate routes dynamically
    ...categories.map((category) => GoRoute(
      path: '/category/${category.id}',
      builder: (context, state) => CategoryScreen(category: category),
    )),
  ],
)
```

## Best Practices

### 1. Keep Shell Simple
The shell should only contain persistent UI elements. Avoid complex logic in the shell builder.

```dart
// Good
ShellRoute(
  builder: (context, state, child) => Scaffold(
    appBar: AppBar(title: Text('My App')),
    body: child,
  ),
  routes: [/* child routes */],
)

// Avoid
ShellRoute(
  builder: (context, state, child) {
    // Don't put complex logic here
    final data = await fetchData(); // This will cause issues
    return ComplexWidget(data: data, child: child);
  },
  routes: [/* child routes */],
)
```

### 2. Use State Management
For complex state, use proper state management solutions.

```dart
// Using Provider
ShellRoute(
  builder: (context, state, child) => ChangeNotifierProvider(
    create: (context) => NavigationState(),
    child: ShellLayout(child: child),
  ),
  routes: [/* child routes */],
)

// Using Riverpod
ShellRoute(
  builder: (context, state, child) => ProviderScope(
    child: ShellLayout(child: child),
  ),
  routes: [/* child routes */],
)
```

### 3. Handle Responsive Design
Make sure your shell works on different screen sizes.

```dart
ShellRoute(
  builder: (context, state, child) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return MobileShell(child: child);
    } else if (screenWidth < 1200) {
      return TabletShell(child: child);
    } else {
      return DesktopShell(child: child);
    }
  },
  routes: [/* child routes */],
)
```

### 4. Optimize Performance
Avoid unnecessary rebuilds and heavy computations.

```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavigationBar(
        // Use const constructors where possible
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  },
  routes: [/* child routes */],
)
```

## Common Patterns

### 1. Tab Navigation
```dart
ShellRoute(
  builder: (context, state, child) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: child,
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
    );
  },
  routes: [/* child routes */],
)
```

### 2. Master-Detail Layout
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: Row(
        children: [
          // Master list
          Expanded(
            flex: 1,
            child: MasterList(),
          ),
          VerticalDivider(),
          // Detail view
          Expanded(
            flex: 2,
            child: child,
          ),
        ],
      ),
    );
  },
  routes: [/* detail routes */],
)
```

### 3. Modal Navigation
```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => ModalContent(),
        ),
        child: Icon(Icons.add),
      ),
    );
  },
  routes: [/* child routes */],
)
```

## Troubleshooting

### Common Issues

1. **State Not Preserved**
   - Ensure you're using `StatefulWidget` for screens that need state
   - Check that you're not recreating widgets unnecessarily

2. **Navigation Not Working**
   - Verify routes are properly defined in the `routes` list
   - Check that paths match exactly (including leading slashes)
   - Ensure you're using the correct navigation methods (`context.go()`, `context.push()`, etc.)

3. **UI Not Responsive**
   - Test on different screen sizes
   - Use `MediaQuery` to adapt to different screen sizes
   - Consider using `LayoutBuilder` for more complex responsive behavior

4. **Performance Issues**
   - Avoid heavy computations in the shell builder
   - Use `const` constructors where possible
   - Consider using `AutomaticKeepAliveClientMixin` for expensive widgets

### Debug Tips

1. **Use GoRouter's Debug Tools**
   ```dart
   GoRouter(
     debugLogDiagnostics: true, // Enable debug logging
     routes: [/* routes */],
   )
   ```

2. **Check Route Configuration**
   ```dart
   // Print current route configuration
   print(GoRouter.of(context).routerDelegate.currentConfiguration);
   ```

3. **Monitor Navigation Events**
   ```dart
   ShellRoute(
     builder: (context, state, child) {
       debugPrint('ShellRoute builder called for: ${state.uri.path}');
       return ShellLayout(child: child);
     },
     routes: [/* child routes */],
   )
   ```

4. **Test Deep Linking**
   - Test direct URL access to all routes
   - Verify browser back/forward buttons work
   - Check that URLs are properly formatted

## Conclusion

ShellRoute is a powerful tool for creating sophisticated navigation experiences in Flutter apps. By understanding its properties and following best practices, you can create apps with persistent navigation, state preservation, and excellent user experience.

Remember to:
- Keep your shell simple and focused
- Use proper state management for complex scenarios
- Test on different screen sizes and devices
- Optimize for performance
- Follow Flutter and GoRouter best practices

Happy coding! 🚀
