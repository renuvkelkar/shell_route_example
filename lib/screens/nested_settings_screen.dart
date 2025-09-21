import 'package:flutter/material.dart';

class NestedSettingsScreen extends StatefulWidget {
  const NestedSettingsScreen({super.key});

  @override
  State<NestedSettingsScreen> createState() => _NestedSettingsScreenState();
}

class _NestedSettingsScreenState extends State<NestedSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedTheme = 'System';
  double _fontSize = 16.0;
  bool _autoSave = true;
  int _sessionTimeout = 30;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nested Settings',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Configure your nested application preferences',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          // Settings Sections
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSettingsSection(
                    context,
                    'Notifications',
                    Icons.notifications,
                    [
                      SwitchListTile(
                        title: const Text('Enable Notifications'),
                        subtitle: const Text('Receive all notifications'),
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Email Notifications'),
                        subtitle: const Text('Receive notifications via email'),
                        value: _emailNotifications,
                        onChanged: _notificationsEnabled
                            ? (value) {
                                setState(() {
                                  _emailNotifications = value;
                                });
                              }
                            : null,
                      ),
                      SwitchListTile(
                        title: const Text('Push Notifications'),
                        subtitle: const Text('Receive push notifications'),
                        value: _pushNotifications,
                        onChanged: _notificationsEnabled
                            ? (value) {
                                setState(() {
                                  _pushNotifications = value;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsSection(context, 'Appearance', Icons.palette, [
                    SwitchListTile(
                      title: const Text('Dark Mode'),
                      subtitle: const Text('Use dark theme'),
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Language'),
                      subtitle: Text(_selectedLanguage),
                      trailing: DropdownButton<String>(
                        value: _selectedLanguage,
                        items: const [
                          DropdownMenuItem(
                            value: 'English',
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: 'Spanish',
                            child: Text('Spanish'),
                          ),
                          DropdownMenuItem(
                            value: 'French',
                            child: Text('French'),
                          ),
                          DropdownMenuItem(
                            value: 'German',
                            child: Text('German'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedLanguage = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Theme'),
                      subtitle: Text(_selectedTheme),
                      trailing: DropdownButton<String>(
                        value: _selectedTheme,
                        items: const [
                          DropdownMenuItem(
                            value: 'System',
                            child: Text('System'),
                          ),
                          DropdownMenuItem(
                            value: 'Light',
                            child: Text('Light'),
                          ),
                          DropdownMenuItem(value: 'Dark', child: Text('Dark')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedTheme = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Font Size: ${_fontSize.round()}'),
                      subtitle: Slider(
                        value: _fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 12,
                        label: _fontSize.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _fontSize = value;
                          });
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _buildSettingsSection(
                    context,
                    'Data & Privacy',
                    Icons.security,
                    [
                      SwitchListTile(
                        title: const Text('Auto Save'),
                        subtitle: const Text('Automatically save changes'),
                        value: _autoSave,
                        onChanged: (value) {
                          setState(() {
                            _autoSave = value;
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('Session Timeout'),
                        subtitle: Text('$_sessionTimeout minutes'),
                        trailing: DropdownButton<int>(
                          value: _sessionTimeout,
                          items: const [
                            DropdownMenuItem(
                              value: 15,
                              child: Text('15 minutes'),
                            ),
                            DropdownMenuItem(
                              value: 30,
                              child: Text('30 minutes'),
                            ),
                            DropdownMenuItem(value: 60, child: Text('1 hour')),
                            DropdownMenuItem(
                              value: 120,
                              child: Text('2 hours'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _sessionTimeout = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Export Data'),
                        subtitle: const Text('Download your data'),
                        trailing: const Icon(Icons.download),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data export started'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Clear Cache'),
                        subtitle: const Text('Remove temporary files'),
                        trailing: const Icon(Icons.clear),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cache cleared'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsSection(context, 'About', Icons.info, [
                    ListTile(
                      title: const Text('Version'),
                      subtitle: const Text('1.0.0'),
                    ),
                    ListTile(
                      title: const Text('Build'),
                      subtitle: const Text('2024.01.15'),
                    ),
                    ListTile(
                      title: const Text('Privacy Policy'),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Opening Privacy Policy...'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Terms of Service'),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Opening Terms of Service...'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                    ),
                  ]),
                ],
              ),
            ),
          ),
          // Save Button
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    // Reset to default values
                    _notificationsEnabled = true;
                    _emailNotifications = true;
                    _pushNotifications = false;
                    _darkModeEnabled = false;
                    _selectedLanguage = 'English';
                    _selectedTheme = 'System';
                    _fontSize = 16.0;
                    _autoSave = true;
                    _sessionTimeout = 30;
                  });
                },
                child: const Text('Reset'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings saved successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Save Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
