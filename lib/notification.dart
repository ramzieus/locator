import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:locator/model.dart';

class Notification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future showNotificationWithoutSound(RPosition position) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        '1', 'location-bg',
        sound: RawResourceAndroidNotificationSound('notification'),
        playSound: true, importance: Importance.max, priority: Priority.high);

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Location fetched',
      position.name,
      platformChannelSpecifics,
      payload: '',
    );
  }

  Notification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
