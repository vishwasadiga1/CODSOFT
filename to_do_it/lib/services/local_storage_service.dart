import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class LocalStorageService {
  static const String _taskListKey = 'taskList';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_taskListKey, taskList);
  }

  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? taskList = prefs.getStringList(_taskListKey);

    if (taskList == null) return [];

    return taskList.map((task) {
      return Task.fromJson(jsonDecode(task));
    }).toList();
  }
}
