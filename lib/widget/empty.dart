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
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text('No tasks yet!', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          const Text(
            'Tap the + button to add',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
