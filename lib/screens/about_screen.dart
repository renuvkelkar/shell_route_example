import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Screen',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Learn about GoRouter ShellRoute properties and features',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ShellRoute Properties',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPropertyCard(
                    context,
                    'builder',
                    'Required function that builds the shell UI',
                    'Provides the persistent layout container for child routes',
                  ),
                  const SizedBox(height: 12),
                  _buildPropertyCard(
                    context,
                    'routes',
                    'List of child routes within the shell',
                    'Defines all the routes that will be wrapped by the shell',
                  ),
                  const SizedBox(height: 12),
                  _buildPropertyCard(
                    context,
                    'redirect',
                    'Optional redirect function',
                    'Can redirect users based on authentication or other conditions',
                  ),
                  const SizedBox(height: 12),
                  _buildPropertyCard(
                    context,
                    'onExit',
                    'Optional callback when leaving the shell',
                    'Called when navigating away from any route in the shell',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Features',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Persistent UI elements (navigation bars, sidebars)',
                  ),
                  const Text('• State preservation across route changes'),
                  const Text('• Consistent layout structure'),
                  const Text(
                    '• Better performance (no rebuild of shell on route change)',
                  ),
                  const Text('• Nested navigation support'),
                  const Text('• URL-based routing with deep linking'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Use Cases',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Apps with bottom navigation bars'),
                  const Text('• Apps with drawer/sidebar navigation'),
                  const Text('• Multi-tab interfaces'),
                  const Text('• Apps with persistent headers/footers'),
                  const Text('• Complex nested navigation structures'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => context.go('/contact'),
                icon: const Icon(Icons.contact_mail),
                label: const Text('Go to Contact'),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () => context.go('/settings'),
                icon: const Icon(Icons.settings),
                label: const Text('Back to Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(
    BuildContext context,
    String property,
    String description,
    String details,
  ) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            details,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
