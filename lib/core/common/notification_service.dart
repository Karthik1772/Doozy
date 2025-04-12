// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final notificationPlugin = FlutterLocalNotificationsPlugin();

//   bool _isInitialized = false;

//   bool get isInitialized => _isInitialized;
//   //initalization
//   Future<void> initNotification() async {
//     if (_isInitialized) return; //prevent re-initialization

//     //prepare android init settings
//     const initSettingsAndroid = AndroidInitializationSettings('@assets/logo');

//     //prepare ios init settings
//     const initSettingsIOS = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     //init settings
//     const initSettings = InitializationSettings(
//       android: initSettingsAndroid,
//       iOS: initSettingsIOS,
//     );

//     //finally inistialize the plugin
//     await notificationPlugin.initialize(initSettings);
//   }

//   //notification detail setup
//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'daily_channel_id',
//         'daily notifications',
//         channelDescription: 'daily notification channel',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

//   //show notification
//   Future<void> showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//   }) async {
//     return notificationPlugin.show(
//       id,
//       title,
//       body,
//       const NotificationDetails(),
//     );
//   }
// }
