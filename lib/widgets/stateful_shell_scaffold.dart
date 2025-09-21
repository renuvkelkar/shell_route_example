import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatefulShellScaffold extends StatelessWidget {
  const StatefulShellScaffold({required this.navigationShell, super.key});

  // The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRouter StatefulShellRoute Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Row(
        children: [
          // Navigation Sidebar
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              // Use the goBranch method to navigate to the branch
              // It will preserve the state of the previous branch
              navigationShell.goBranch(
                index,
                // A common pattern when using bottom navigation bars is to support
                // navigating to the initial location when tapping the item that is
                // already active.
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.info_outline),
                selectedIcon: Icon(Icons.info),
                label: Text('About'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.contact_mail_outlined),
                selectedIcon: Icon(Icons.contact_mail),
                label: Text('Contact'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_tree_outlined),
                selectedIcon: Icon(Icons.account_tree),
                label: Text('Nested'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main content area - This is the IndexedStack containing the pages
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: navigationShell,
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar for mobile
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outlined),
                  activeIcon: Icon(Icons.info),
                  label: 'About',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_mail_outlined),
                  activeIcon: Icon(Icons.contact_mail),
                  label: 'Contact',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_tree_outlined),
                  activeIcon: Icon(Icons.account_tree),
                  label: 'Nested',
                ),
              ],
            )
          : null,
    );
  }
}
