import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/nested_dashboard_screen.dart';
import 'screens/nested_analytics_screen.dart';
import 'screens/nested_users_screen.dart';
import 'screens/nested_settings_screen.dart';
import 'screens/nested_projects_screen.dart';
import 'screens/nested_tasks_screen.dart';
import 'widgets/stateful_shell_scaffold.dart';
import 'widgets/nested_stateful_shell_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoRouter ShellRoute Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// Root navigator key
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// GoRouter configuration using StatefulShellRoute
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Main StatefulShellRoute - This is the root container for navigation
    StatefulShellRoute.indexedStack(
      // The builder for the shell UI
      builder: (context, state, navigationShell) {
        return StatefulShellScaffold(navigationShell: navigationShell);
      },
      // A list of branches, each with its own navigator and routes
      branches: [
        // Branch 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        // Branch 1: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        // Branch 2: Settings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
        // Branch 3: About
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/about',
              name: 'about',
              builder: (context, state) => const AboutScreen(),
            ),
          ],
        ),
        // Branch 4: Contact
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/contact',
              name: 'contact',
              builder: (context, state) => const ContactScreen(),
            ),
          ],
        ),
        // Branch 5: Nested StatefulShellRoute - This demonstrates nested navigation
        StatefulShellBranch(
          routes: [
            StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) {
                return NestedStatefulShellScaffold(
                  navigationShell: navigationShell,
                );
              },
              branches: [
                // Nested Branch 0: Dashboard
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: '/nested',
                      name: 'nested',
                      builder: (context, state) =>
                          const NestedDashboardScreen(),
                    ),
                  ],
                ),
                // Nested Branch 1: Analytics
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: '/nested/analytics',
                      name: 'nested-analytics',
                      builder: (context, state) =>
                          const NestedAnalyticsScreen(),
                    ),
                  ],
                ),
                // Nested Branch 2: Users
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: '/nested/users',
                      name: 'nested-users',
                      builder: (context, state) => const NestedUsersScreen(),
                    ),
                  ],
                ),
                // Nested Branch 3: Settings
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: '/nested/settings',
                      name: 'nested-settings',
                      builder: (context, state) => const NestedSettingsScreen(),
                    ),
                  ],
                ),
                // Nested Branch 4: Projects
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: '/nested/projects',
                      name: 'nested-projects',
                      builder: (context, state) => const NestedProjectsScreen(),
                    ),
                  ],
                ),
                // Nested Branch 5: Tasks
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: '/nested/tasks',
                      name: 'nested-tasks',
                      builder: (context, state) => const NestedTasksScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
