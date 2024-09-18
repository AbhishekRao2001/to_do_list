import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification service and timezone
  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Schedule a notification for a specific task's due date
  static Future<void> scheduleNotification(Task task) async {
    // Provide a default value (e.g., 0) if task.id is null
    int notificationId = task.id ?? 0;

    if (task.dueDate.isAfter(DateTime.now())) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId, // Use non-nullable notification ID
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

  // Cancel a scheduled notification
  static Future<void> cancelNotification(Task task) async {
    int notificationId = task.id ?? 0; // Provide a default value if id is null
    await flutterLocalNotificationsPlugin.cancel(notificationId); // Cancel by task ID
  }
}
