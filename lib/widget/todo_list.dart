import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/todo_provider.dart';
import 'package:to_do/widget/task_card.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return CustomScrollView(
      slivers: [
        // Pending Tasks Section
        if (todoProvider.todos.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Pending Tasks (${todoProvider.todos.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        if (todoProvider.todos.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => TaskCard(todo: todoProvider.todos[index]),
              childCount: todoProvider.todos.length,
            ),
          ),

        // Completed Tasks Section
        if (todoProvider.completedTodos.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Completed Tasks (${todoProvider.completedTodos.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        if (todoProvider.completedTodos.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  TaskCard(todo: todoProvider.completedTodos[index]),
              childCount: todoProvider.completedTodos.length,
            ),
          ),

        // Add some bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }
}
