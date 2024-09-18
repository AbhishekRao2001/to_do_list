import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';

class StorageService {
  final String taskKey = 'tasks';

  Future<void> saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskList = tasks.map((task) => jsonEncode(task.toMap())).toList();
    await prefs.setStringList(taskKey, taskList);
  }

  Future<List<Task>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList(taskKey);

    if (taskList != null) {
      return taskList
          .map((taskString) => Task.fromMap(jsonDecode(taskString)))
          .toList();
    }

    return [];
  }
}
