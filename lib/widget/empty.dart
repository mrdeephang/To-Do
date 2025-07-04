import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No tasks yet!',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add a new task',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
