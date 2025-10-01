import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/todo_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/EasyConst/color.dart';

class TaskCard extends StatelessWidget {
  final TodoItem todo;
  const TaskCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
            elevation: themeProvider.isDarkMode ? 2 : 1,
            color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CheckboxListTile(
                checkColor: Colors.blueGrey,
                contentPadding: const EdgeInsets.only(left: 8, right: 16),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: themeProvider.isDarkMode
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                subtitle: _buildSubtitle(context),
                secondary: Icon(
                  Icons.drag_handle,
                  color: themeProvider.isDarkMode
                      ? Colors.grey[400]
                      : Colors.grey[600],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: todo.isCompleted,
                onChanged: (_) => _toggleStatus(context),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                activeColor: themeProvider.isDarkMode ? color2 : color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildSubtitle(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isOverdue =
        todo.dueDate != null &&
        todo.dueDate!.isBefore(DateTime.now()) &&
        !todo.isCompleted;

    if (todo.description?.isNotEmpty == true || todo.dueDate != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (todo.description?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                todo.description!,
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDarkMode
                      ? Colors.grey[400]
                      : Colors.grey[700],
                ),
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
                  color: isOverdue
                      ? Colors.red
                      : (themeProvider.isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600]),
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM d, y • h:mm a').format(todo.dueDate!),
                  style: TextStyle(
                    fontSize: 12,
                    color: isOverdue
                        ? Colors.red
                        : (themeProvider.isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600]),
                  ),
                ),
                if (isOverdue) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Overdue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
                SnackBar(
                  content: const Text(
                    'Task deleted!',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor:
                      Provider.of<ThemeProvider>(context).isDarkMode
                      ? color2
                      : color,
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isOverdue =
        todo.dueDate != null &&
        todo.dueDate!.isBefore(DateTime.now()) &&
        !todo.isCompleted;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: themeProvider.isDarkMode
          ? Colors.grey[800]
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                  if (todo.isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),

              if (todo.description?.isNotEmpty == true) ...[
                const SizedBox(height: 16),
                Text(
                  todo.description!,
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? Colors.grey[300]
                        : Colors.grey[700],
                  ),
                ),
              ],

              if (todo.dueDate != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isOverdue
                        ? Colors.red.withOpacity(0.1)
                        : (themeProvider.isDarkMode
                              ? Colors.grey[700]
                              : Colors.grey[100]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: isOverdue
                            ? Colors.red
                            : (themeProvider.isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600]),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Due Date',
                              style: TextStyle(
                                fontSize: 12,
                                color: themeProvider.isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                            ),
                            Text(
                              DateFormat.yMMMMd().add_jm().format(
                                todo.dueDate!,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isOverdue
                                    ? Colors.red
                                    : (themeProvider.isDarkMode
                                          ? Colors.white
                                          : Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isOverdue)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'OVERDUE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.isDarkMode ? color2 : color,
                    foregroundColor: Colors.white,
                  ),
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
