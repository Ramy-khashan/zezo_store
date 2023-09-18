import 'package:flutter_local_notifications/flutter_local_notifications.dart'; 

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/launch_background');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings( );

    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings  );
  }

  Future<void> showNotification(int id, String title, String body ) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
     
        const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            channelDescription:'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/launch_background',
          // ongoing: true,
          //
          // styleInformation: BigTextStyleInformation(''),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
