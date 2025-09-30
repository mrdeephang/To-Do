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
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showTaskDetails(context),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _confirmDelete(context),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.only(left: 8, right: 16),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: _buildSubtitle(context),
                secondary: const Icon(Icons.drag_handle),
                controlAffinity: ListTileControlAffinity.leading,
                value: todo.isCompleted,
                onChanged: (_) => _toggleStatus(context),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildSubtitle(BuildContext context) {
    if (todo.description?.isNotEmpty == true || todo.dueDate != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (todo.description?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                todo.description!,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (todo.dueDate != null)
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color:
                      todo.dueDate!.isBefore(DateTime.now()) &&
                          !todo.isCompleted
                      ? Colors.red
                      : null,
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM d, y • h:mm a').format(todo.dueDate!),
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        todo.dueDate!.isBefore(DateTime.now()) &&
                            !todo.isCompleted
                        ? Colors.red
                        : null,
                  ),
                ),
              ],
            ),
        ],
      );
    }
    return null;
  }

  void _toggleStatus(BuildContext context) {
    Provider.of<TodoProvider>(context, listen: false).toggleTodoStatus(todo.id);
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TodoProvider>(
                context,
                listen: false,
              ).deleteTodo(todo.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task deleted!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showTaskDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (todo.description?.isNotEmpty == true) ...[
                const SizedBox(height: 16),
                Text(todo.description!),
              ],
              if (todo.dueDate != null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color:
                          todo.dueDate!.isBefore(DateTime.now()) &&
                              !todo.isCompleted
                          ? Colors.red
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(DateFormat.yMMMMd().add_jm().format(todo.dueDate!)),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
