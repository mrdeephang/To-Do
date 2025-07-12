import 'package:flutter/material.dart';
import 'package:to_do/database/todo_database.dart';
import 'package:to_do/models/task.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoItem> _todos = [];
  final TodoDatabase _database = TodoDatabase.instance;

  List<TodoItem> get todos =>
      _todos.where((todo) => !todo.isCompleted).toList();
  List<TodoItem> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();

  Future<void> loadTodos() async {
    _todos.clear();
    _todos.addAll(await _database.readAllTodos());
    notifyListeners();
  }

  Future<void> addTodo(TodoItem todo) async {
    await _database.createTodo(todo);
    await loadTodos();
  }

  Future<void> toggleTodoStatus(String id) async {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final updatedTodo = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
        updatedAt: DateTime.now(),
      );
      await _database.updateTodo(updatedTodo);
      await loadTodos();
    }
  }

  Future<void> deleteTodo(String id) async {
    await _database.deleteTodo(id);
    await loadTodos();
  }

  Future<void> clearCompleted() async {
    for (final todo in completedTodos) {
      await _database.deleteTodo(todo.id);
    }
    await loadTodos();
  }
}
