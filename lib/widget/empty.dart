import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 96,
            color: Colors.grey.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text('No tasks yet!', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text('Tap the + button to add your first task'),
        ],
      ),
    );
  }
}
