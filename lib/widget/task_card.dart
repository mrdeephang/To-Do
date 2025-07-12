import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/EasyConst/styles.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/todo_provider.dart';
import 'package:to_do/providers/theme_provider.dart'; // NEW IMPORT
import 'package:to_do/EasyConst/color.dart'; // Assuming this contains your color constants

class TaskCard extends StatelessWidget {
  final TodoItem todo;
  const TaskCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    ); //Get theme provider
    final bool isDarkMode =
        themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    // Theme-aware colors
    final Color cardColor = isDarkMode ? Colors.grey[850]! : Colors.white;
    final Color textColor = isDarkMode ? Colors.grey[100]! : Colors.grey[900]!;
    final Color secondaryTextColor = isDarkMode
        ? Colors.grey[400]!
        : Colors.grey[600]!;
    final Color checkboxColor = isDarkMode ? Colors.blue[200]! : color;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        // MOVED TO OUTSIDE SLIDABLE
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showTaskDetails(context),
        child: Slidable(
          // NOW INSIDE INKWELL
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _confirmDelete(context),
                backgroundColor: Colors.red[400]!,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 1,
            child: Padding(
              // REMOVED INKWELL FROM HERE
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.only(left: 8, right: 16),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    color: textColor,
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: _buildSubtitle(context, secondaryTextColor),
                secondary: Icon(Icons.drag_handle, color: secondaryTextColor),
                controlAffinity: ListTileControlAffinity.leading,
                value: todo.isCompleted,
                onChanged: (_) => _toggleStatus(context),
                activeColor: checkboxColor,
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

  Widget? _buildSubtitle(BuildContext context, Color textColor) {
    if (todo.description?.isNotEmpty == true || todo.dueDate != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (todo.description?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                todo.description!,
                style: TextStyle(color: textColor, fontSize: 14),
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
                      ? Colors.red[400]
                      : textColor,
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM d, y • h:mm a').format(todo.dueDate!),
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        todo.dueDate!.isBefore(DateTime.now()) &&
                            !todo.isCompleted
                        ? Colors.red[400]
                        : textColor,
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
        title: const Text('Confirm '),
        content: const Text(
          'Are you sure to delete?',
          style: TextStyle(fontSize: 18),
        ),
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
                  backgroundColor: color,
                  content: Text(
                    'Task deleted!',
                    style: TextStyle(fontSize: 18, color: color1),
                  ),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode =
        themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              if (todo.description?.isNotEmpty == true) ...[
                const SizedBox(height: 16),
                Text(
                  todo.description!,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
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
                          ? Colors.red[400]
                          : isDarkMode
                          ? Colors.grey[400]
                          : Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat.yMMMMd().add_jm().format(todo.dueDate!),
                      style: TextStyle(
                        color:
                            todo.dueDate!.isBefore(DateTime.now()) &&
                                !todo.isCompleted
                            ? Colors.red[400]
                            : isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.blue[700] : color,
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(color: isDarkMode ? Colors.white : color1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
