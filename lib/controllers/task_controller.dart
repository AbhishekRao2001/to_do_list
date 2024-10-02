import 'package:get/get.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils/notification_service.dart';
import 'package:to_do_list/utils/storage_service.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs; // All tasks
  var filteredTasks = <Task>[].obs; // Filtered tasks based on search and sorting
  var searchQuery = ''.obs; // Observable for search query
  var sortCriteria = 'priority'.obs; // Default sorting by priority

  final StorageService storageService;

  // Constructor that accepts StorageService as a parameter
  TaskController({required this.storageService});

  @override
  void onInit() {
    super.onInit();
    loadTasks(); // Load tasks when the controller is initialized

    // Debounce and listen for changes in searchQuery and sortCriteria
    debounce(searchQuery, (_) => filterAndSortTasks(), time: const Duration(milliseconds: 300));
    ever(sortCriteria, (_) => filterAndSortTasks());
  }

  // Add task
  void addTask(Task task) {
    task.id = DateTime.now().millisecondsSinceEpoch; // Generate a unique ID
    int notificationId = _getValidNotificationId(); // Use valid ID for notification
    tasks.add(task);
    NotificationService.scheduleNotification(task, notificationId); // Pass valid ID
    saveTasks(); // Save tasks to Hive
    filterAndSortTasks(); // Re-filter and sort tasks after adding
  }

  // Update task
  void updateTask(Task updatedTask) {
    int index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;

      // Update the notification
      NotificationService.scheduleNotification(updatedTask, _getValidNotificationId()); // Pass the valid notification ID
      saveTasks(); // Save tasks to Hive
      filterAndSortTasks(); // Re-filter and sort tasks after updating
    }
  }

  // Update task completion status
  void updateTaskCompletion(Task task, bool isCompleted) {
    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index].isCompleted = isCompleted;

      // Update the notification
      NotificationService.scheduleNotification(tasks[index], _getValidNotificationId()); // Pass the valid notification ID
      saveTasks(); // Save tasks to Hive
      tasks.refresh(); // Refresh the list to trigger UI updates
      filterAndSortTasks(); // Re-filter and sort tasks after completion status change
    }
  }

  // Delete task
  void deleteTask(Task task) {
    tasks.remove(task);
    NotificationService.cancelNotification(task); // Call static method using class name
    saveTasks(); // Save tasks to Hive
    filterAndSortTasks(); // Re-filter and sort tasks after deletion
  }

  // Load tasks from Hive database
  void loadTasks() async {
    try {
      tasks.value = await storageService.loadTasks();
      filterAndSortTasks(); // Initially filter and sort all tasks
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  // Save tasks to Hive database
  void saveTasks() {
    storageService.saveTasks(tasks);
  }

  // Filter tasks based on search query and sort them
  void filterAndSortTasks() {
    List<Task> filteredList;
    if (searchQuery.value.isEmpty) {
      filteredList = tasks; // If search query is empty, show all tasks
    } else {
      filteredList = tasks.where((task) =>
          task.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          (task.description ?? '').toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }

    sortTasks(filteredList); // Sort filtered tasks
  }

  // Sort tasks based on the criteria
  void sortTasks(List<Task> taskList) {
    switch (sortCriteria.value) {
      case 'priority':
        taskList.sort((a, b) => a.priority.compareTo(b.priority));
        break;
      case 'dueDate':
        taskList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case 'creationDate':
        taskList.sort((a, b) => a.id.compareTo(b.id));
        break;
      default:
        break;
    }

    filteredTasks.assignAll(taskList); // Update the filteredTasks observable
  }

  // Update the sort criteria
  void updateSortCriteria(String criteria) {
    sortCriteria.value = criteria; // Update the sort criteria
  }

  // Generate a valid notification ID
  int _getValidNotificationId() {
    return DateTime.now().millisecondsSinceEpoch % 2147483647; // Range of a 32-bit signed integer
  }
}

