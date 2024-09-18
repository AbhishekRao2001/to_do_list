import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../utils/notification_service.dart';
import '../utils/storage_service.dart';

class TaskBindings extends Bindings {
  @override
  void dependencies() {
    // Register TaskController, NotificationService, and StorageService
    Get.lazyPut<TaskController>(() => TaskController()); // Using lazyPut to initialize TaskController when needed
    Get.lazyPut<NotificationService>(() => NotificationService()); // Same for NotificationService
    Get.lazyPut<StorageService>(() => StorageService()); // Same for StorageService
  }
}

