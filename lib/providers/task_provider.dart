import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<String> _taskIds = []; // To keep track of task IDs

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
      return Task(id: id, title: title, isCompleted: isCompleted);
    }).toList();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    _taskIds.forEach((id) {
      final task = _tasks.firstWhere((task) => task.id == id);
      prefs.setString('task_$id', task.title);
      prefs.setBool('completed_$id', task.isCompleted);
    });
    prefs.setStringList('taskIds', _taskIds);
  }

  void addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
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

    if (task.isCompleted) {
      deleteTask(task.id); // Delete task if completed
    } else {
      _saveTasks();
    }
  }
}
