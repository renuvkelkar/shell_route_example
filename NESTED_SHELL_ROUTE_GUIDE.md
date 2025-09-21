# Nested ShellRoute Demonstration Guide

## Overview

This project now includes a comprehensive demonstration of **nested ShellRoute** functionality in GoRouter. The nested navigation shows how you can have a shell within a shell, creating complex multi-level navigation structures.

## What is Nested ShellRoute?

Nested ShellRoute allows you to create multiple levels of persistent UI shells. This means you can have:
- A main shell with primary navigation
- A nested shell with secondary navigation
- Multiple levels of nested shells (though typically 2-3 levels are practical)

## Project Structure

```
lib/
├── main.dart                          # Main app with nested ShellRoute configuration
├── widgets/
│   ├── shell_layout.dart             # Main shell layout (primary navigation)
│   └── nested_shell_layout.dart      # Nested shell layout (secondary navigation)
└── screens/
    ├── home_screen.dart              # Main screens
    ├── profile_screen.dart
    ├── settings_screen.dart
    ├── about_screen.dart
    ├── contact_screen.dart
    ├── nested_dashboard_screen.dart  # Nested screens
    ├── nested_analytics_screen.dart
    ├── nested_users_screen.dart
    ├── nested_settings_screen.dart
    ├── nested_projects_screen.dart
    └── nested_tasks_screen.dart
```

## Navigation Hierarchy

```
Main Shell (ShellLayout)
├── Home (/)
├── Profile (/profile)
├── Settings (/settings)
├── About (/about)
├── Contact (/contact)
└── Nested Shell (NestedShellLayout)
    ├── Dashboard (/nested)
    ├── Analytics (/nested/analytics)
    ├── Users (/nested/users)
    ├── Settings (/nested/settings)
    ├── Projects (/nested/projects)
    └── Tasks (/nested/tasks)
```

## Key Features Demonstrated

### 1. **Multi-Level Navigation**
- **Primary Level**: Main app navigation (Home, Profile, Settings, etc.)
- **Secondary Level**: Nested navigation within the nested shell (Dashboard, Analytics, Users, etc.)

### 2. **Persistent UI at Multiple Levels**
- **Main Shell**: App bar, primary navigation rail/bottom bar
- **Nested Shell**: Secondary sidebar, nested navigation, info bar

### 3. **State Preservation**
- Each shell level maintains its own state
- Navigation within nested shell preserves state
- Returning to main shell preserves main shell state

### 4. **Responsive Design**
- Both shells adapt to different screen sizes
- Mobile: Bottom navigation for main shell
- Desktop: Side navigation for both shells

## Implementation Details

### Main Router Configuration

```dart
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // Main ShellRoute
    ShellRoute(
      builder: (context, state, child) {
        return ShellLayout(child: child);
      },
      routes: [
        // Main routes
        GoRoute(path: '/', builder: (context, state) => HomeScreen()),
        GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
        // ... other main routes
        
        // Nested ShellRoute
        ShellRoute(
          builder: (context, state, child) {
            return NestedShellLayout(child: child);
          },
          routes: [
            // Nested routes
            GoRoute(path: '/nested', builder: (context, state) => NestedDashboardScreen()),
            GoRoute(path: '/nested/analytics', builder: (context, state) => NestedAnalyticsScreen()),
            // ... other nested routes
          ],
        ),
      ],
    ),
  ],
);
```

### Nested Shell Layout

The nested shell provides:
- **Secondary Navigation**: Sidebar with nested menu items
- **Breadcrumb Navigation**: Shows current location within nested structure
- **Consistent Styling**: Matches the main shell but with distinct visual hierarchy
- **Back Navigation**: Easy return to main shell

## Use Cases for Nested ShellRoute

### 1. **Admin Dashboards**
```
Main App
├── Public Pages
└── Admin Shell
    ├── Dashboard
    ├── User Management
    ├── Analytics
    └── Settings
```

### 2. **Multi-Tenant Applications**
```
Main App
├── Tenant Selection
└── Tenant Shell
    ├── Tenant Dashboard
    ├── Tenant Settings
    └── Tenant Data
```

### 3. **Complex Workflows**
```
Main App
├── Workflow List
└── Workflow Shell
    ├── Workflow Steps
    ├── Workflow Settings
    └── Workflow Results
```

### 4. **Feature Modules**
```
Main App
├── Core Features
└── Module Shell
    ├── Module Dashboard
    ├── Module Tools
    └── Module Reports
```

## Advanced Patterns

### 1. **Conditional Nested Shells**
```dart
ShellRoute(
  builder: (context, state, child) {
    final user = AuthService.currentUser;
    
    if (user?.isAdmin == true) {
      return AdminShellLayout(child: child);
    } else if (user?.isModerator == true) {
      return ModeratorShellLayout(child: child);
    } else {
      return UserShellLayout(child: child);
    }
  },
  routes: [/* routes */],
)
```

### 2. **Dynamic Nested Routes**
```dart
ShellRoute(
  builder: (context, state, child) => NestedShellLayout(child: child),
  routes: [
    // Static routes
    GoRoute(path: '/nested', builder: (context, state) => NestedDashboardScreen()),
    
    // Dynamic routes based on data
    ...projects.map((project) => GoRoute(
      path: '/nested/project/${project.id}',
      builder: (context, state) => ProjectScreen(project: project),
    )),
  ],
)
```

### 3. **Nested Shell with Redirects**
```dart
ShellRoute(
  builder: (context, state, child) => NestedShellLayout(child: child),
  redirect: (context, state) {
    // Check if user has access to nested features
    if (!AuthService.hasNestedAccess) {
      return '/unauthorized';
    }
    return null;
  },
  routes: [/* nested routes */],
)
```

## Best Practices

### 1. **Limit Nesting Depth**
- Typically, 2-3 levels of nesting are sufficient
- More than 3 levels can confuse users
- Consider alternative navigation patterns for deeper hierarchies

### 2. **Clear Visual Hierarchy**
- Use different colors, sizes, or styles for different shell levels
- Provide clear breadcrumbs or navigation indicators
- Ensure users always know where they are

### 3. **Consistent Navigation Patterns**
- Use similar navigation patterns across shell levels
- Maintain consistent interaction patterns
- Provide clear entry and exit points

### 4. **Performance Considerations**
- Each shell level adds to the widget tree
- Consider lazy loading for nested shells
- Optimize state management across shell levels

### 5. **Accessibility**
- Ensure proper focus management across shell levels
- Provide keyboard navigation support
- Use semantic labels for screen readers

## Testing Nested Navigation

### 1. **Navigation Testing**
```dart
testWidgets('nested navigation works correctly', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Navigate to nested shell
  await tester.tap(find.text('Try Nested Navigation'));
  await tester.pumpAndSettle();
  
  // Verify nested shell is displayed
  expect(find.text('Nested Dashboard'), findsOneWidget);
  
  // Navigate within nested shell
  await tester.tap(find.text('Analytics'));
  await tester.pumpAndSettle();
  
  // Verify nested navigation works
  expect(find.text('Analytics'), findsOneWidget);
});
```

### 2. **State Preservation Testing**
```dart
testWidgets('state is preserved across nested navigation', (tester) async {
  // Test that state is preserved when navigating within nested shell
  // Test that state is preserved when returning to main shell
});
```

## Common Issues and Solutions

### 1. **Navigation State Confusion**
**Problem**: Users get lost in nested navigation
**Solution**: Provide clear breadcrumbs and navigation indicators

### 2. **State Management Complexity**
**Problem**: Managing state across multiple shell levels
**Solution**: Use proper state management solutions (Provider, Riverpod, Bloc)

### 3. **Performance Issues**
**Problem**: Multiple shell levels cause performance issues
**Solution**: Optimize widget rebuilds and consider lazy loading

### 4. **URL Management**
**Problem**: Complex URL structures for nested routes
**Solution**: Use meaningful URL patterns and provide URL shortcuts

## Conclusion

Nested ShellRoute is a powerful pattern for creating complex navigation structures in Flutter apps. When used appropriately, it provides:

- **Clear Information Architecture**: Logical grouping of related features
- **Improved User Experience**: Familiar navigation patterns
- **Better State Management**: Isolated state for different app sections
- **Scalable Architecture**: Easy to add new features and modules

Remember to:
- Keep nesting levels reasonable (2-3 levels max)
- Provide clear visual hierarchy
- Test navigation thoroughly
- Consider performance implications
- Maintain accessibility standards

The demonstration in this project shows a practical implementation of nested ShellRoute that you can use as a starting point for your own applications.

## Running the Demo

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the web app**:
   ```bash
   ./run_web.sh
   # OR
   flutter run -d web-server --web-port 8080
   ```

3. **Test the nested navigation**:
   - Click "Try Nested Navigation" on the home screen
   - Navigate through the nested shell using the sidebar
   - Notice how the main shell navigation remains available
   - Test state preservation by filling forms and navigating

Happy coding! 🚀
