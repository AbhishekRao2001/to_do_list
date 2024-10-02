import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../utils/notification_service.dart';
import '../utils/storage_service.dart';

class TaskBindings extends Bindings {
  @override
  void dependencies() {
    // Register StorageService first
    Get.lazyPut<StorageService>(() => StorageService()); // Same for StorageService

    // Register TaskController with StorageService
    Get.lazyPut<TaskController>(() => TaskController(storageService: Get.find<StorageService>())); // Pass StorageService instance

    // Register NotificationService
    Get.lazyPut<NotificationService>(() => NotificationService()); // Same for NotificationService
  }
}


