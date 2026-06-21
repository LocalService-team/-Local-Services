import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    Future<void> initialize() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await notificationsPlugin.initialize(settings: settings);
  }

  Future<void> requestPermission() async {
    await notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  Future<void> showNotification() async {
    AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'daily_recommendation',
      'Daily Recommendation',
      channelDescription: 'Daily recommendations for nearby places',
      importance: Importance.high,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      id: 0,
      title: 'Daily Recommendation',
      body: 'Discover nearby hospitals, cafes, and places today!',
      notificationDetails: notificationDetails,
    );
  }
}
