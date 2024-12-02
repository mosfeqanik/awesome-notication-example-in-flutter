import 'package:awesome_notication_example/screens/home_screen.dart';
import 'package:awesome_notication_example/services/notification_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    const secondaryColor =Color(0xff6D28D9);

    return MaterialApp(
      navigatorKey: MainApp.navigatorKey,
      title: 'Awesome Notification',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) =>
                MyHomePage(title: MyApp.name)
            );

          case '/notification-page':
            return MaterialPageRoute(builder: (context) {
              final ReceivedAction receivedAction = settings
                  .arguments as ReceivedAction;
              return NotificationDetailsPage(receivedAction: receivedAction.);
            });

          default:
            assert(false, 'Page ${settings.name} not found');
            return null;
        }
      },

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


