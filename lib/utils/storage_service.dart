import 'package:hive/hive.dart';
import '../models/task.dart';

class StorageService {
  final String taskBoxName = 'tasksBox'; // Ensure this matches your main.dart initialization

  // Generate a valid ID for Hive
  int _getValidId(int id) {
    return id % 0xFFFFFFFF; // Ensures ID is within the valid range for Hive
  }

  // Clone a Task object
  Task _cloneTask(Task task) {
    return Task(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      priority: task.priority,
      isCompleted: task.isCompleted,
    );
  }

  // Save tasks to Hive
  Future<void> saveTasks(List<Task> tasks) async {
    var box = await Hive.openBox<Task>(taskBoxName); // Open the Hive box
    await box.clear(); // Clear the box before saving the updated tasks
    for (var task in tasks) {
      int validId = _getValidId(task.id); // Get a valid ID
      Task clonedTask = _cloneTask(task); // Clone the task
      await box.put(validId, clonedTask); // Use valid ID as the key
    }
    print('Saving tasks: ${tasks.length}');
    await box.close(); // Close the box after saving
  }

  // Load tasks from Hive
  Future<List<Task>> loadTasks() async {
    var box = await Hive.openBox<Task>(taskBoxName); // Open the Hive box
    List<Task> tasks = box.values.toList(); // Retrieve all tasks
    print('Loaded tasks: ${tasks.length}');
    await box.close(); // Close the box after loading
    return tasks;
  }
}
