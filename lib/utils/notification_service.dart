import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:to_do_list/models/task.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification plugin
  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Set your app icon here

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // Initialize for other platforms like iOS if needed
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Schedule a notification for a specific task's due date
  static Future<void> scheduleNotification(
      Task task, int notificationId) async {
    if (task.dueDate.isAfter(DateTime.now())) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId, // Use the provided notification ID
        'Task Reminder', // Title
        'Your task "${task.title}" is due soon!', // Body
        tz.TZDateTime.from(
            task.dueDate, tz.local), // Schedule based on due date
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_channel', // Channel ID
            'Task Notifications', // Channel Name
            channelDescription:
                'Channel for task notifications', // Channel Description
            importance: Importance.high,
            priority: Priority.high,
            icon: '@android:drawable/ic_dialog_info',
          ),
        ),
        androidAllowWhileIdle: true, // Allow notification while idle
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation
                .absoluteTime, // Handle local time interpretation
        matchDateTimeComponents:
            DateTimeComponents.dateAndTime, // Match date and time
      );
    }
  }

  // Cancel the notification for a specific task
  static Future<void> cancelNotification(Task task) async {
    await flutterLocalNotificationsPlugin
        .cancel(task.id); // Use the task ID to cancel
  }
}
