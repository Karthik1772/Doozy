// import 'package:elegant_notification/elegant_notification.dart';
// import 'package:elegant_notification/resources/arrays.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
  
//   // Global key to access context from anywhere
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
//   NotificationService._internal();
  
//   // Display in-app notification
//   void showTaskNotification({
//     required String title,
//     required String message,
//     NotificationType type = NotificationType.warning,
//   }) {
//     if (navigatorKey.currentContext != null) {
//       switch (type) {
//         case NotificationType.info:
//           ElegantNotification.info(
//             title: Text(title),
//             description: Text(message),
//             animation: AnimationType.fromTop,
//             notificationPosition: NotificationPosition.topRight,
//             onDismiss: () {},
//           ).show(navigatorKey.currentContext!);
//           break;
//         case NotificationType.success:
//           ElegantNotification.success(
//             title: Text(title),
//             description: Text(message),
//             animation: AnimationType.fromTop,
//             notificationPosition: NotificationPosition.topRight,
//             onDismiss: () {},
//           ).show(navigatorKey.currentContext!);
//           break;
//         case NotificationType.error:
//           ElegantNotification.error(
//             title: Text(title),
//             description: Text(message),
//             animation: AnimationType.fromTop,
//             notificationPosition: NotificationPosition.topRight,
//             onDismiss: () {},
//           ).show(navigatorKey.currentContext!);
//           break;
//         case NotificationType.warning:
//           ElegantNotification.warning(
//             title: Text(title),
//             description: Text(message),
//             animation: AnimationType.fromTop,
//             notificationPosition: NotificationPosition.topRight,
//             onDismiss: () {},
//           ).show(navigatorKey.currentContext!);
//           break;
//       }
//     }
//   }
  
//   // Schedule a task by saving it to SharedPreferences with timing info
//   Future<void> scheduleTaskReminder(String taskId, String title, DateTime dueDate) async {
//     final prefs = await SharedPreferences.getInstance();
    
//     // Save reminder for 1 day before due date
//     if (dueDate.isAfter(DateTime.now().add(Duration(days: 1)))) {
//       DateTime notificationTime = dueDate.subtract(Duration(days: 1));
//       await prefs.setString('reminder_${taskId}_day_before', notificationTime.toIso8601String());
//       await prefs.setString('reminder_${taskId}_day_before_title', title);
//     }
    
//     // Save reminder for exact due date
//     await prefs.setString('reminder_${taskId}_due', dueDate.toIso8601String());
//     await prefs.setString('reminder_${taskId}_due_title', title);
//   }
  
//   // Cancel scheduled task reminders
//   Future<void> cancelTaskReminders(String taskId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('reminder_${taskId}_day_before');
//     await prefs.remove('reminder_${taskId}_day_before_title');
//     await prefs.remove('reminder_${taskId}_due');
//     await prefs.remove('reminder_${taskId}_due_title');
//   }
  
//   // Check for tasks that need notifications
//   Future<void> checkScheduledReminders() async {
//     final prefs = await SharedPreferences.getInstance();
//     final now = DateTime.now();
//     final allKeys = prefs.getKeys();
    
//     // Check all reminder keys
//     for (var key in allKeys) {
//       if (key.startsWith('reminder_') && !key.endsWith('_title')) {
//         final reminderTimeStr = prefs.getString(key);
//         final titleKey = '${key}_title';
//         final title = prefs.getString(titleKey) ?? 'Task Reminder';
        
//         if (reminderTimeStr != null) {
//           final reminderTime = DateTime.parse(reminderTimeStr);
          
//           // Check if this reminder is due (within the last hour)
//           if (reminderTime.isAfter(now.subtract(Duration(hours: 1))) && 
//               reminderTime.isBefore(now)) {
            
//             // Determine notification type and message
//             String message;
//             String notificationTitle;
//             NotificationType type;
            
//             if (key.contains('day_before')) {
//               notificationTitle = 'Task Due Tomorrow';
//               message = 'Task "$title" is due tomorrow!';
//               type = NotificationType.info;
//             } else if (key.contains('due')) {
//               notificationTitle = 'Task Due Now';
//               message = 'Task "$title" is due now!';
//               type = NotificationType.warning;
//             } else if (key.contains('overdue')) {
//               notificationTitle = 'Task Overdue';
//               message = 'Task "$title" is overdue!';
//               type = NotificationType.error;
//             } else {
//               continue;
//             }
            
//             // Display notification if we have context
//             if (navigatorKey.currentContext != null) {
//               showTaskNotification(
//                 title: notificationTitle,
//                 message: message,
//                 type: type,
//               );
//             }
            
//             // Remove this reminder after it's been shown
//             await prefs.remove(key);
//             await prefs.remove(titleKey);
//           }
//         }
//       }
//     }
//   }
  
//   // Check for overdue tasks
//   Future<void> checkOverdueTasks(List<dynamic> tasks) async {
//     final prefs = await SharedPreferences.getInstance();
//     final now = DateTime.now();
    
//     for (final task in tasks) {
//       // Skip if already marked as overdue or completed
//       if (task.isCompleted || prefs.containsKey('overdue_${task.id}')) continue;
      
//       if (task.dueDate != null && task.dueDate.isBefore(now)) {
//         // Mark as overdue and save for notification
//         await prefs.setString('reminder_${task.id}_overdue', now.toIso8601String());
//         await prefs.setString('reminder_${task.id}_overdue_title', task.title);
        
//         // Flag this task as already notified for overdue
//         await prefs.setBool('overdue_${task.id}', true);
//       }
//     }
//   }
// }

// enum NotificationType {
//   info,
//   success,
//   warning,
//   error,
// }