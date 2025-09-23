import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedShellLayout extends StatelessWidget {
  const NestedShellLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested ShellRoute Demo'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Row(
        children: [
          // Nested Navigation Sidebar
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Nested Navigation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: [
                      _buildNavItem(
                        context,
                        icon: Icons.dashboard,
                        title: 'Dashboard',
                        route: '/nested',
                        isSelected: _isSelected(context, '/nested'),
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.analytics,
                        title: 'Analytics',
                        route: '/nested/analytics',
                        isSelected: _isSelected(context, '/nested/analytics'),
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.people,
                        title: 'Users',
                        route: '/nested/users',
                        isSelected: _isSelected(context, '/nested/users'),
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.settings,
                        title: 'Settings',
                        route: '/nested/settings',
                        isSelected: _isSelected(context, '/nested/settings'),
                      ),
                      const Divider(),
                      _buildNavItem(
                        context,
                        icon: Icons.folder,
                        title: 'Projects',
                        route: '/nested/projects',
                        isSelected: _isSelected(context, '/nested/projects'),
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.task,
                        title: 'Tasks',
                        route: '/nested/tasks',
                        isSelected: _isSelected(context, '/nested/tasks'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: Container(padding: const EdgeInsets.all(16.0), child: child),
          ),
        ],
      ),
      // Bottom info bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'This is a nested ShellRoute - notice the persistent sidebar navigation',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSelected(BuildContext context, String route) {
    final currentPath = GoRouterState.of(context).uri.path;
    return currentPath == route;
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onTap: () => context.go(route),
      ),
    );
  }
}
