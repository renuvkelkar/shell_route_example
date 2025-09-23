import 'package:flutter/material.dart';

class NestedAnalyticsScreen extends StatefulWidget {
  const NestedAnalyticsScreen({super.key});

  @override
  State<NestedAnalyticsScreen> createState() => _NestedAnalyticsScreenState();
}

class _NestedAnalyticsScreenState extends State<NestedAnalyticsScreen> {
  String _selectedTimeRange = '7 days';
  final List<String> _timeRanges = ['24 hours', '7 days', '30 days', '90 days'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Analytics',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            DropdownButton<String>(
              value: _selectedTimeRange,
              items: _timeRanges.map((String range) {
                return DropdownMenuItem<String>(
                  value: range,
                  child: Text(range),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTimeRange = newValue!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Analytics data for $_selectedTimeRange',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        // Charts Row
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Growth',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 48,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Chart Placeholder',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revenue',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.attach_money,
                                size: 48,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Chart Placeholder',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Metrics Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMetricCard(
              context,
              'Page Views',
              '12,345',
              Icons.visibility,
              Colors.blue,
            ),
            _buildMetricCard(
              context,
              'Sessions',
              '8,901',
              Icons.timeline,
              Colors.green,
            ),
            _buildMetricCard(
              context,
              'Bounce Rate',
              '45%',
              Icons.trending_down,
              Colors.orange,
            ),
            _buildMetricCard(
              context,
              'Avg. Duration',
              '3:24',
              Icons.access_time,
              Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Data Table
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Pages',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Page')),
                    DataColumn(label: Text('Views')),
                    DataColumn(label: Text('Unique Visitors')),
                    DataColumn(label: Text('Bounce Rate')),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(Text('/dashboard')),
                        DataCell(Text('2,345')),
                        DataCell(Text('1,890')),
                        DataCell(Text('32%')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('/profile')),
                        DataCell(Text('1,876')),
                        DataCell(Text('1,234')),
                        DataCell(Text('28%')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('/settings')),
                        DataCell(Text('1,234')),
                        DataCell(Text('987')),
                        DataCell(Text('45%')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('/analytics')),
                        DataCell(Text('987')),
                        DataCell(Text('654')),
                        DataCell(Text('38%')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
