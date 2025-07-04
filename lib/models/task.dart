class TodoItem {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  bool isCompleted;

  TodoItem({
    required this.title,
    this.description,
    this.dueDate,
    this.isCompleted = false,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();
}
