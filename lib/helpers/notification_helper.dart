import 'package:TrentaGiorni/models/user.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:TrentaGiorni/models/received_notification.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final BehaviorSubject<ReceivedNotification>
    didReceivedLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
var initializationSettings;

init() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  initializePlatformSpecifics();
  tz.initializeTimeZones();
  tz.setLocalLocation(
      tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));
}

initializePlatformSpecifics() {
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
}

setListenerForLowerVersions(Function onNotificationInLowerVersions) {
  didReceivedLocalNotificationSubject.listen((receivedNotification) {
    onNotificationInLowerVersions(receivedNotification);
  });
}

setOnNotificationClick(Function onNotificationClick) async {
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    onNotificationClick(payload);
  });
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'CHANNEL_ID',
    'CHANNEL_NAME',
    "CHANNEL_DESCRIPTION",
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'plain title',
    'plain body',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

Future<void> scheduleNotification(User user) async {
  var scheduleNotificationDateTime = tz.TZDateTime.now(tz.local)
      .add(user.date.add(Duration(days: 2)).difference(DateTime.now()));
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 1',
    'CHANNEL_NAME 1',
    "CHANNEL_DESCRIPTION 1",
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.zonedSchedule(
    user.id,
    'Reminder pesatura',
    '${user.name} ${user.surname}',
    scheduleNotificationDateTime,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> deleteNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<List<ActiveNotification>> showActiveNotifications() async {
  final List<ActiveNotification> activeNotifications =
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.getActiveNotifications();
  print("ActiveNotifications: $activeNotifications");
  return activeNotifications;
}

Future<List<PendingNotificationRequest>> showPendingNotifications() async {
  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  print("PendingNotifications: $pendingNotificationRequests");
  return pendingNotificationRequests;
}
