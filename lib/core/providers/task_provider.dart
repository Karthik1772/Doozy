import 'package:demo/core/models/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<String> _taskIds = [];

  TaskProvider() {
    _loadTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    _taskIds = prefs.getStringList('taskIds') ?? [];
    _tasks = _taskIds.map((id) {
      final title = prefs.getString('task_$id') ?? '';
      final isCompleted = prefs.getBool('completed_$id') ?? false;
      final createdAtString = prefs.getString('createdAt_$id');
      final dueDateString = prefs.getString('dueDate_$id');
      final createdAt = createdAtString != null
          ? DateTime.tryParse(createdAtString) ?? DateTime.now()
          : DateTime.now();
      final dueDate = dueDateString != null
          ? DateTime.tryParse(dueDateString)
          : null;
      return Task(
        id: id,
        title: title,
        isCompleted: isCompleted,
        createdAt: createdAt,
        dueDate: dueDate,
      );
    }).toList();
    _sortTasks();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    for (final task in _tasks) {
      prefs.setString('task_${task.id}', task.title);
      prefs.setBool('completed_${task.id}', task.isCompleted);
      prefs.setString('createdAt_${task.id}', task.createdAt.toIso8601String());
      if (task.dueDate != null) {
        prefs.setString('dueDate_${task.id}', task.dueDate!.toIso8601String());
      }
    }
    prefs.setStringList('taskIds', _taskIds);
    _sortTasks();
  }

  void _sortTasks() {
    _tasks.sort((a, b) => a.isCompleted ? 1 : -1);
  }

  void addTask(String title, DateTime? dueDate) {
    final newTask = Task(id: const Uuid().v4(), title: title, dueDate: dueDate);
    _tasks.add(newTask);
    _taskIds.add(newTask.id);
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _taskIds.remove(id);
    _saveTasks();
    notifyListeners();
  }

  void editTask(String id, String newTitle) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.title = newTitle;
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    _saveTasks();
    notifyListeners();
  }
}
