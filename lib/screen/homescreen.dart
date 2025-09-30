import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/EasyConst/color.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/providers/todo_provider.dart';
import 'package:to_do/screen/addtask.dart';
import 'package:to_do/widget/empty.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
            ? color2
            : color,
        title: const Text('TO DO', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            onPressed: () => Provider.of<TodoProvider>(
              context,
              listen: false,
            ).clearCompleted(),
          ),
          IconButton(
            icon: Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) => Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
              ),
            ),
            onPressed: () => Provider.of<ThemeProvider>(
              context,
              listen: false,
            ).toggleTheme(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
            ? color2
            : color,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTaskScreen()),
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.todos.isEmpty && provider.completedTodos.isEmpty) {
            return const EmptyState();
          }
          return CustomScrollView(
            slivers: [
              // ... rest of your existing code
            ],
          );
        },
      ),
    );
  }
}
