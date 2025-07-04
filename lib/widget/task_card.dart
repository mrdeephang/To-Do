import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/todo_provider.dart';

class TaskCard extends StatelessWidget {
  final TodoItem todo;
  const TaskCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) =>
                  context.read<TodoProvider>().deleteTodo(todo.id),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          child: CheckboxListTile(
            title: Text(todo.title),
            subtitle: todo.dueDate != null
                ? Text(
                    'Due: ${DateFormat.yMMMd().add_jm().format(todo.dueDate!)}',
                    style: TextStyle(
                      color: todo.dueDate!.isBefore(DateTime.now())
                          ? Colors.red
                          : Colors.grey,
                    ),
                  )
                : null,
            secondary: const Icon(Icons.drag_handle),
            value: todo.isCompleted,
            onChanged: (_) =>
                context.read<TodoProvider>().toggleTodoStatus(todo.id),
          ),
        ),
      ),
    );
  }
}
