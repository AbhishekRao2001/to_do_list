import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/controllers/task_controller.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils/notification_service.dart'; // Import your NotificationService
import 'package:to_do_list/utils/storage_service.dart';
import 'bindings/bindings.dart';
import 'views/task_list_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the Task adapter
  Hive.registerAdapter(TaskAdapter());

  // Open the tasks box
  final tasksBox =
      await Hive.openBox<Task>('tasksBox'); // Ensure to specify the type

  // Initialize the notification service
  await NotificationService.initialize();

  Get.put(StorageService()); // Register StorageService instance
  Get.put(TaskController(
      storageService:
          Get.find<StorageService>())); // Pass the StorageService instance

  tz.initializeTimeZones();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      initialBinding:
          TaskBindings(), // Use the TaskBindings for dependency injection
      home: TaskListPage(), // Your main task list page
    );
  }
}
