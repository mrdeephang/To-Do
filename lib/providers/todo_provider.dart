import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos =>
      _todos.where((todo) => !todo.isCompleted).toList();
  List<TodoItem> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();

  void addTodo(TodoItem todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
    notifyListeners();
  }
}
