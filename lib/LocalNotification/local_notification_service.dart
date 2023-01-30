import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static initializeNotification() async {
    await plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: DarwinInitializationSettings(),
        ), onDidReceiveNotificationResponse: (response) {
      var data = response.payload;
      if (data!.isNotEmpty) {
        print(data);
      }
    });
  }

  static const AndroidNotificationChannel androidChannel =
      AndroidNotificationChannel(
    'notification',
    'notificationchannel',
    description: 'description',
    importance: Importance.max,
    playSound: true,
  );

  static AndroidNotificationDetails androidDetail = AndroidNotificationDetails(
    androidChannel.id,
    androidChannel.name,
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    icon: "@mipmap/ic_launcher",
    ongoing: true,
    styleInformation: const BigTextStyleInformation(""),
    visibility: NotificationVisibility.public,
    actions: [
      AndroidNotificationAction("1", "reply"),
      AndroidNotificationAction('2', "view proile")
    ],
  );

  static NotificationDetails details = NotificationDetails(
      android: androidDetail, iOS: const DarwinNotificationDetails());

  static sheduleNotification(id, title, body) async {
    tz.initializeTimeZones();
    await plugin.zonedSchedule(id, title, body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 20)), details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  static showPeriodicNotification(id, title, body) async {}

  static openNotification(id, title, bigText) async {}

  static showNotification(label, id, title, bigText) async {
    var androidStyleDetail = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: "@mipmap/ic_launcher",
      ongoing: true,
      styleInformation: BigTextStyleInformation(bigText),
      visibility: NotificationVisibility.public,
      actions: [
        AndroidNotificationAction(
          "1",
          "reply",
        ),
        AndroidNotificationAction('2', "view proile")
      ],
    );
    var styleDetail = NotificationDetails(android: androidStyleDetail);

    if (label == 'periodic') {
      await plugin.periodicallyShow(
          id, title, bigText, RepeatInterval.everyMinute, styleDetail);
    } else if (label == 'shedule') {
      tz.initializeTimeZones();
      await plugin.zonedSchedule(
          id,
          title,
          bigText,
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 20)),
          styleDetail,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
    } else {}
  }

  groupNotification() async {
    List<ActiveNotification>? activeNotification = await plugin
        .resolvePlatformSpecificImplementation()!
        .getActiveNotifications();

    if (activeNotification.isNotEmpty) {
      List<String> lines =
          activeNotification.map((e) => e.title.toString()).toList();
      var inboxInformation = InboxStyleInformation(lines,
          contentTitle: "${activeNotification.length - 1} updates",
          summaryText: "${activeNotification.length - 1} updates");
      var androidNotificationDetail = AndroidNotificationDetails('1', 'name',
          styleInformation: inboxInformation,
          setAsGroupSummary: true,
          groupKey: 'group');

      var notificationDetails = NotificationDetails();
    }
  }
}
