import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/EasyConst/color.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/providers/todo_provider.dart';
import 'package:to_do/screen/addtask.dart';
import 'package:to_do/widget/empty.dart';
import 'package:to_do/widget/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text(
          'TO DO',
          style: TextStyle(
            color: color1,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: color1),
            onPressed: () => Provider.of<TodoProvider>(
              context,
              listen: false,
            ).clearCompleted(),
          ),

          IconButton(
            icon: Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) => Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: color1,
              ),
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              Provider.of<TodoProvider>(
                context,
                listen: false,
              ).loadTodos(); // Existing refresh
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        child: const Icon(Icons.add, color: color1),
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
              if (provider.todos.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Active Tasks(${provider.todos.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => TaskCard(todo: provider.todos[index]),
                  childCount: provider.todos.length,
                ),
              ),
              if (provider.completedTodos.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Completed (${provider.completedTodos.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      TaskCard(todo: provider.completedTodos[index]),
                  childCount: provider.completedTodos.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
