import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/theme_provider.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist_rounded,
            size: 80,
            color: themeProvider.isDarkMode
                ? Colors.grey[400]
                : Colors.grey[500],
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: themeProvider.isDarkMode
                  ? Colors.grey[400]
                  : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first task',
            style: TextStyle(
              fontSize: 14,
              color: themeProvider.isDarkMode
                  ? Colors.grey[500]
                  : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
