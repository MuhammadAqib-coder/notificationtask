import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notification_task/LocalNotification/local_notification_service.dart';
import 'package:notification_task/PushNotification/chat.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var data = message.data;
      if (data.isNotEmpty) {
        LocalNotificationService.plugin.show(
            message.hashCode,
            message.data['title'],
            message.data['body'],
            LocalNotificationService.details);
      }
    });
    FirebaseMessaging.instance.onTokenRefresh
        .listen(saveTokenToDatabase)
        .onError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
    });
    requestPermission();
    superToken();
    setupInteractedMessage();
    LocalNotificationService.initializeNotification();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (kDebugMode) {
      // print(message.data);
      var notification = message.notification;
      if (notification != null) {
        if (notification.body == 'chat') {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const ChatView()));
        }
      }
    }
  }

  @override
  dispose() {
    // LocalNotificationService.plugin.cancel(1);
    LocalNotificationService.plugin.cancelAll();
    super.dispose();
  }

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("user granted permission");
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("user granted provisional permission");
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      if (kDebugMode) {
        print("user denied permission");
      }
    } else {
      if (kDebugMode) {
        print("something else");
      }
    }
  }

  superToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    saveTokenToDatabase(token);
  }

  saveTokenToDatabase(token) async {
    await FirebaseFirestore.instance
        .collection("token")
        .doc("user")
        .set({"token_id": token});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  var doc = await FirebaseFirestore.instance
                      .collection('token')
                      .doc('user')
                      .get();
                  await sendPushNotification(doc.data()!['token_id']);
                },
                child: const Text('push notification')),
            ElevatedButton(
                onPressed: () async {
                  await LocalNotificationService.showNotification(
                      'shedule',
                      0,
                      'shedule notification',
                      'shedule notification with big text. Now you can expand the notificaion');
                },
                child: const Text('Shedule Notification')),
            ElevatedButton(
                onPressed: () async {
                  await LocalNotificationService.showNotification(
                      'periodic',
                      1,
                      "Periodic Notification",
                      "shedule notification with big text. Now you can expand the notificaion");
                },
                child: const Text("Periodically")),
          ],
        ),
      ),
    );
  }

  sendPushNotification(token) async {
    try {
      var headers = {
        'Authorization': 'key=',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
      request.body = json.encode({
        "to": "/topics/weather",
        "data": {
          "body":
              "Notification Body,Notification Body,Notification Body,Notification Body,Notification Body,Notification Body,Notification Body,Notification Body,Notification Body",
          "title": "Notification Title"
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(await response.stream.bytesToString());
        }
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
