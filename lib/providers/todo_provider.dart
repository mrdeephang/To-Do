import 'package:flutter/material.dart';
import 'package:to_do/database/todo_database.dart';
import 'package:to_do/models/task.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoItem> _todos = [];
  final TodoDatabase _database = TodoDatabase.instance;
  bool _isLoading = false;

  List<TodoItem> get todos =>
      _todos.where((todo) => !todo.isCompleted).toList();
  List<TodoItem> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();
  bool get isLoading => _isLoading;

  Future<void> loadTodos() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _todos.clear();
      final loadedTodos = await _database.readAllTodos();
      _todos.addAll(loadedTodos);
    } catch (e) {
      print('Error loading todos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTodo(TodoItem todo) async {
    try {
      await _database.createTodo(todo);
      await loadTodos(); // Reload to get the updated list
    } catch (e) {
      print('Error adding todo: $e');
      rethrow;
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final updatedTodo = _todos[index].copyWith(
          isCompleted: !_todos[index].isCompleted,
          updatedAt: DateTime.now(),
        );
        await _database.updateTodo(updatedTodo);
        await loadTodos();
      }
    } catch (e) {
      print('Error toggling todo: $e');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _database.deleteTodo(id);
      await loadTodos();
    } catch (e) {
      print('Error deleting todo: $e');
    }
  }

  Future<void> clearCompleted() async {
    try {
      for (final todo in completedTodos) {
        await _database.deleteTodo(todo.id);
      }
      await loadTodos();
    } catch (e) {
      print('Error clearing completed todos: $e');
    }
  }

  // Add method to get todo by id
  TodoItem? getTodoById(String id) {
    try {
      return _todos.firstWhere((todo) => todo.id == id);
    } catch (e) {
      return null;
    }
  }
}
