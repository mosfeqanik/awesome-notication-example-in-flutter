import 'package:awesome_notication_example/widgets/notification_button.dart';
import 'package:awesome_notication_example/widgets/top_bar.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../services/notification_service.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String routeHome = '/', routeNotification = '/notification-page';
  @override
  void initState() {
    NotificationService.startListeningNotificationEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).primaryColor, Colors.grey[200]!],
          ),
        ),
        child: Column(
          children: [
            Topbar(title: "Awesome Notification"),
            NotificationButton(
              text: "Normal Notification",
              onPressed: () async {
                await NotificationService.showNotification(
                    title: "title of the notification",
                    body: "body of the notification");
              },
            ),
            NotificationButton(
              text: "Notification with Summary",
              onPressed: () async {
                await NotificationService.showNotification(
                  title: "title of the notification",
                  body: "body of the notification",
                  summary: "Small Summary",
                  notificationLayout: NotificationLayout.Inbox,
                );
              },
            ),
            NotificationButton(
              text: "Progress bar Notification",
              onPressed: () async {
                await NotificationService.showNotification(
                  title: "title of the notification",
                  body: "body of the notification",
                  summary: "Small Summary",
                  notificationLayout: NotificationLayout.ProgressBar,
                );
              },
            ),
            NotificationButton(
              text: "Message Notification",
              onPressed: () async {
                await NotificationService.showNotification(
                  title: "title of the notification",
                  body: "body of the notification",
                  summary: "Small Summary",
                  notificationLayout: NotificationLayout.Messaging,
                );
              },
            ),
            NotificationButton(
              text: "Big Image Notification",
              onPressed: () async {
                await NotificationService.showNotification(
                    title: "title of the notification",
                    body: "body of the notification",
                    summary: "Small Summary",
                    notificationLayout: NotificationLayout.BigPicture,
                    bigPicture:
                    "https://miro.medium.com/v2/resize:fit:720/format:webp/1*hg9WraQ9tw1SsJzfaCmMjA.png");
              },
            ),
            NotificationButton(
              text: "Action Buttons Notification",
              onPressed: () async {
                await NotificationService.showNotification(
                    title: "title of the notification",
                    body: "body of the notification",
                    payload: {
                      "navigate": "true"
                    },
                    actionButtons: [
                      NotificationActionButton(
                          key: "check",
                          label: "Check it out",
                          actionType: ActionType.KeepOnTop,
                          color: Colors.amberAccent),
                      NotificationActionButton(
                          key: "check",
                          label: "out",
                          actionType: ActionType.KeepOnTop,
                          color: Colors.green)
                    ]);
              },
            ),
            NotificationButton(
              text: "Scheduled Notification",
              onPressed: () async {
                await NotificationService.showNotification(
                    title: "Scheduled Notification",
                    body: "Notification was fired after 5 seconds",
                    scheduled: true,
                    interval: 5);
              },
            ),
          ],
        ),
      ),
    );
  }
}

