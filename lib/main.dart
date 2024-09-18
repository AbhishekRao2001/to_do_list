import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:to_do_list/controllers/task_controller.dart';
import 'package:to_do_list/utils/notification_service.dart'; // Import your NotificationService
import 'bindings/bindings.dart';
import 'views/task_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the notification service
  await NotificationService.init();
  Get.put(
      TaskController()); // Register the TaskController 
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
