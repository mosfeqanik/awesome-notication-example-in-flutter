import 'dart:ui';

import 'package:awesome_notication_example/screens/second_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: "high_importance_channel",
            channelName: "high_importance_channel",
            channelDescription: "Notification Channel for basic test",
            playSound: true,
            defaultColor: const Color(0xff9D50DD),
            ledColor: Colors.white,
            channelShowBadge: true,
            criticalAlerts: true),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: "high_importance_channel_group",
            channelGroupName: "Group 1")
      ],
      debug: true,
    );
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod);
  }
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreatedMethod");
  }
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationDisplayedMethod");
  }
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("onActionReceivedMethod");
    MainApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
            (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("onDismissActionReceivedMethod");
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      MainApp.navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => SecondScreen(),
        ),
      );
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: "high_importance_channel",
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
          payload: payload,
          bigPicture: bigPicture,
        ),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true)
            : null);
  }
}
