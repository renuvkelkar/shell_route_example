import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedStatefulShellScaffold extends StatelessWidget {
  const NestedStatefulShellScaffold({required this.navigationShell, super.key});

  // The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested StatefulShellRoute Demo'),
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
                        index: 0,
                        isSelected: navigationShell.currentIndex == 0,
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.analytics,
                        title: 'Analytics',
                        index: 1,
                        isSelected: navigationShell.currentIndex == 1,
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.people,
                        title: 'Users',
                        index: 2,
                        isSelected: navigationShell.currentIndex == 2,
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.settings,
                        title: 'Settings',
                        index: 3,
                        isSelected: navigationShell.currentIndex == 3,
                      ),
                      const Divider(),
                      _buildNavItem(
                        context,
                        icon: Icons.folder,
                        title: 'Projects',
                        index: 4,
                        isSelected: navigationShell.currentIndex == 4,
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.task,
                        title: 'Tasks',
                        index: 5,
                        isSelected: navigationShell.currentIndex == 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main content area - This is the IndexedStack containing the pages
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: navigationShell,
            ),
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
              'This is a nested StatefulShellRoute - notice the persistent sidebar navigation',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int index,
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
        onTap: () {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
