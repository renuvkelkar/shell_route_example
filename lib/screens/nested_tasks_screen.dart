import 'package:flutter/material.dart';

class NestedTasksScreen extends StatefulWidget {
  const NestedTasksScreen({super.key});

  @override
  State<NestedTasksScreen> createState() => _NestedTasksScreenState();
}

class _NestedTasksScreenState extends State<NestedTasksScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'id': 1,
      'title': 'Implement user authentication',
      'description': 'Add login and registration functionality',
      'status': 'In Progress',
      'priority': 'High',
      'assignee': 'John Doe',
      'dueDate': '2024-02-15',
      'project': 'Mobile App Development',
      'completed': false,
    },
    {
      'id': 2,
      'title': 'Design dashboard UI',
      'description': 'Create wireframes and mockups for the dashboard',
      'status': 'Completed',
      'priority': 'Medium',
      'assignee': 'Jane Smith',
      'dueDate': '2024-01-30',
      'project': 'Web Dashboard',
      'completed': true,
    },
    {
      'id': 3,
      'title': 'Setup database schema',
      'description': 'Design and implement database tables',
      'status': 'To Do',
      'priority': 'High',
      'assignee': 'Bob Johnson',
      'dueDate': '2024-02-20',
      'project': 'API Integration',
      'completed': false,
    },
    {
      'id': 4,
      'title': 'Write unit tests',
      'description': 'Add comprehensive test coverage',
      'status': 'In Progress',
      'priority': 'Medium',
      'assignee': 'Alice Brown',
      'dueDate': '2024-02-25',
      'project': 'Mobile App Development',
      'completed': false,
    },
    {
      'id': 5,
      'title': 'Code review',
      'description': 'Review pull requests and provide feedback',
      'status': 'To Do',
      'priority': 'Low',
      'assignee': 'Charlie Wilson',
      'dueDate': '2024-02-28',
      'project': 'Database Migration',
      'completed': false,
    },
  ];

  String _selectedStatus = 'All';
  final List<String> _statuses = ['All', 'To Do', 'In Progress', 'Completed'];
  String _selectedPriority = 'All';
  final List<String> _priorities = ['All', 'High', 'Medium', 'Low'];
  String _selectedProject = 'All';
  final List<String> _projects = [
    'All',
    'Mobile App Development',
    'Web Dashboard',
    'API Integration',
    'Database Migration',
  ];

  List<Map<String, dynamic>> get _filteredTasks {
    return _tasks.where((task) {
      final matchesStatus =
          _selectedStatus == 'All' || task['status'] == _selectedStatus;
      final matchesPriority =
          _selectedPriority == 'All' || task['priority'] == _selectedPriority;
      final matchesProject =
          _selectedProject == 'All' || task['project'] == _selectedProject;
      return matchesStatus && matchesPriority && matchesProject;
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
                'Tasks',
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
                        'Create Task functionality would be implemented here',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('New Task'),
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
              const SizedBox(width: 8),
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
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedProject,
                  isExpanded: true,
                  items: _projects.map((String project) {
                    return DropdownMenuItem<String>(
                      value: project,
                      child: Text(
                        project.length > 15
                            ? '${project.substring(0, 15)}...'
                            : project,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedProject = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Tasks List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                final task = _filteredTasks[index];
                return _buildTaskCard(context, task);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Map<String, dynamic> task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Checkbox(
          value: task['completed'],
          onChanged: (value) {
            setState(() {
              task['completed'] = value!;
              task['status'] = value ? 'Completed' : 'To Do';
            });
          },
        ),
        title: Text(
          task['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task['completed'] ? TextDecoration.lineThrough : null,
            color: task['completed']
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task['description']),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStatusChip(task['status']),
                const SizedBox(width: 8),
                _buildPriorityChip(task['priority']),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    task['project'],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              task['assignee'],
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              'Due: ${task['dueDate']}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            PopupMenuButton<String>(
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$value action for ${task['title']}'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'Edit', child: Text('Edit Task')),
                const PopupMenuItem(value: 'Assign', child: Text('Reassign')),
                const PopupMenuItem(
                  value: 'Duplicate',
                  child: Text('Duplicate'),
                ),
                const PopupMenuItem(value: 'Delete', child: Text('Delete')),
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
      case 'To Do':
        color = Colors.orange;
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
