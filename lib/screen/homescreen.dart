import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/EasyConst/color.dart';
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
            fontFamily: "poppins",
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: color1),
            onPressed: () => context.read<TodoProvider>().clearCompleted(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: color),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTaskScreen()),
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.todos.isEmpty) {
            return const EmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
              final todo = provider.todos[index];
              return TaskCard(todo: todo);
            },
          );
        },
      ),
    );
  }
}
