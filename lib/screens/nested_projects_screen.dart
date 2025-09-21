import 'package:flutter/material.dart';

class NestedProjectsScreen extends StatefulWidget {
  const NestedProjectsScreen({super.key});

  @override
  State<NestedProjectsScreen> createState() => _NestedProjectsScreenState();
}

class _NestedProjectsScreenState extends State<NestedProjectsScreen> {
  final List<Map<String, dynamic>> _projects = [
    {
      'id': 1,
      'name': 'Mobile App Development',
      'description': 'Flutter mobile application for iOS and Android',
      'status': 'In Progress',
      'progress': 75,
      'teamSize': 5,
      'dueDate': '2024-03-15',
      'priority': 'High',
      'color': Colors.blue,
    },
    {
      'id': 2,
      'name': 'Web Dashboard',
      'description': 'React-based admin dashboard',
      'status': 'Completed',
      'progress': 100,
      'teamSize': 3,
      'dueDate': '2024-01-30',
      'priority': 'Medium',
      'color': Colors.green,
    },
    {
      'id': 3,
      'name': 'API Integration',
      'description': 'RESTful API development and integration',
      'status': 'Planning',
      'progress': 25,
      'teamSize': 4,
      'dueDate': '2024-04-20',
      'priority': 'High',
      'color': Colors.orange,
    },
    {
      'id': 4,
      'name': 'Database Migration',
      'description': 'Migrate from MySQL to PostgreSQL',
      'status': 'In Progress',
      'progress': 60,
      'teamSize': 2,
      'dueDate': '2024-02-28',
      'priority': 'Low',
      'color': Colors.purple,
    },
    {
      'id': 5,
      'name': 'UI/UX Redesign',
      'description': 'Complete redesign of user interface',
      'status': 'On Hold',
      'progress': 40,
      'teamSize': 3,
      'dueDate': '2024-05-10',
      'priority': 'Medium',
      'color': Colors.red,
    },
  ];

  String _selectedStatus = 'All';
  final List<String> _statuses = [
    'All',
    'Planning',
    'In Progress',
    'Completed',
    'On Hold',
  ];
  String _selectedPriority = 'All';
  final List<String> _priorities = ['All', 'High', 'Medium', 'Low'];

  List<Map<String, dynamic>> get _filteredProjects {
    return _projects.where((project) {
      final matchesStatus =
          _selectedStatus == 'All' || project['status'] == _selectedStatus;
      final matchesPriority =
          _selectedPriority == 'All' ||
          project['priority'] == _selectedPriority;
      return matchesStatus && matchesPriority;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Projects',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Create Project functionality would be implemented here',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('New Project'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Filters
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedStatus,
                  isExpanded: true,
                  items: _statuses.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedPriority,
                  isExpanded: true,
                  items: _priorities.map((String priority) {
                    return DropdownMenuItem<String>(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Projects Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                final project = _filteredProjects[index];
                return _buildProjectCard(context, project);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: project['color'],
                    shape: BoxShape.circle,
                  ),
                ),
                _buildStatusChip(project['status']),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project['name'],
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              project['description'],
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${project['progress']}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: project['progress'] / 100,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(project['color']),
                ),
              ],
            ),
            const Spacer(),
            // Project Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${project['teamSize']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                _buildPriorityChip(project['priority']),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due: ${project['dueDate']}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$value action for ${project['name']}'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Edit',
                      child: Text('Edit Project'),
                    ),
                    const PopupMenuItem(
                      value: 'View Details',
                      child: Text('View Details'),
                    ),
                    const PopupMenuItem(
                      value: 'Archive',
                      child: Text('Archive'),
                    ),
                    const PopupMenuItem(value: 'Delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Completed':
        color = Colors.green;
        break;
      case 'In Progress':
        color = Colors.blue;
        break;
      case 'Planning':
        color = Colors.orange;
        break;
      case 'On Hold':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.red;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      case 'Low':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
