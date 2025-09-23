import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellLayout extends StatelessWidget {
  const ShellLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRouter ShellRoute Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Row(
        children: [
          // Navigation Sidebar
          NavigationRail(
            selectedIndex: _getSelectedIndex(context),
            onDestinationSelected: (index) {
              _onDestinationSelected(context, index);
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
          // Main content area
          Expanded(
            child: Container(padding: const EdgeInsets.all(16.0), child: child),
          ),
        ],
      ),
      // Bottom Navigation Bar for mobile
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _getSelectedIndex(context),
              onTap: (index) {
                _onDestinationSelected(context, index);
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

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/':
        return 0;
      case '/profile':
        return 1;
      case '/settings':
        return 2;
      case '/about':
        return 3;
      case '/contact':
        return 4;
      case '/nested':
      case '/nested/analytics':
      case '/nested/users':
      case '/nested/settings':
      case '/nested/projects':
      case '/nested/tasks':
        return 5;
      default:
        return 0;
    }
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/profile');
        break;
      case 2:
        context.go('/settings');
        break;
      case 3:
        context.go('/about');
        break;
      case 4:
        context.go('/contact');
        break;
      case 5:
        context.go('/nested');
        break;
    }
  }
}
