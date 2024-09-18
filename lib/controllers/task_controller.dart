import 'package:get/get.dart';
import '../models/task.dart';
import '../utils/notification_service.dart';
import '../utils/storage_service.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs; // All tasks
  var filteredTasks = <Task>[].obs; // Filtered tasks based on search and sorting
  var searchQuery = ''.obs; // Observable for search query
  var sortCriteria = 'priority'.obs; // Default sorting by priority

  final StorageService storageService = Get.put(StorageService());
  final NotificationService notificationService =
      Get.put(NotificationService());

  @override
  void onInit() {
    super.onInit();
    loadTasks();

    // When search query or sort criteria change, filter and sort tasks
    debounce(searchQuery, (_) => filterAndSortTasks(), 
        time: const Duration(milliseconds: 300));
    ever(sortCriteria, (_) => filterAndSortTasks());
  }

  // Add task
  void addTask(Task task) {
    task.id = DateTime.now().millisecondsSinceEpoch;
    tasks.add(task);
    NotificationService.scheduleNotification(task);
    saveTasks();
    filterAndSortTasks(); // Re-filter and sort tasks after adding
  }

  // Update task
  void updateTask(Task updatedTask) {
    int index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      NotificationService.scheduleNotification(updatedTask);
      saveTasks();
      filterAndSortTasks(); // Re-filter and sort tasks after updating
    }
  }

  // Update task completion status
  void updateTaskCompletion(Task task, bool isCompleted) {
    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index].isCompleted = isCompleted;
      NotificationService.scheduleNotification(
          tasks[index]); // Re-schedule if needed
      saveTasks();
      tasks.refresh(); // Refresh the list to trigger UI updates
      filterAndSortTasks(); // Re-filter and sort tasks after completion status change
    }
  }

  // Delete task
  void deleteTask(Task task) {
    tasks.remove(task);
    NotificationService.cancelNotification(task);
    saveTasks();
    filterAndSortTasks(); // Re-filter and sort tasks after deletion
  }

  // Load tasks from storage
  void loadTasks() async {
    tasks.value = await storageService.loadTasks();
    filterAndSortTasks(); // Initially filter and sort all tasks
  }

  // Save tasks to storage
  void saveTasks() {
    storageService.saveTasks(tasks);
  }

  // Filter tasks based on search query and sort them
  void filterAndSortTasks() {
    // Filter tasks based on search query
    List<Task> filteredList;
    if (searchQuery.value.isEmpty) {
      filteredList = tasks; // If search query is empty, show all tasks
    } else {
      filteredList = tasks.where((task) =>
          task.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          (task.description ?? '')
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase())).toList();
    }

    // Sort the filtered tasks based on the selected criteria
    sortTasks(filteredList);
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
        taskList.sort((a, b) => a.id!.compareTo(b.id!));
        break;
      default:
        break;
    }

    // Update the filteredTasks observable with the sorted list
    filteredTasks.assignAll(taskList);
  }

  // Update the sort criteria
  void updateSortCriteria(String criteria) {
    sortCriteria.value = criteria;
  }
}
