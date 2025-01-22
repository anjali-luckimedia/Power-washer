import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:power_washer/blocs/home_data/home_data_bloc.dart';
import 'package:power_washer/blocs/notification/notification_bloc.dart';
import 'package:power_washer/blocs/search/search_bloc.dart';
import 'package:power_washer/blocs/service/service_data_bloc.dart';
import 'package:power_washer/blocs/service_details/service_details_bloc.dart';
import 'package:power_washer/blocs/user_profile/user_profile_bloc.dart';
import 'package:power_washer/firebase_options.dart';
import 'package:power_washer/repositary/api_repositary.dart';
import 'package:power_washer/screen/auth_screen/login_screen.dart';
import 'package:power_washer/screen/auth_screen/otp_screen.dart';
import 'package:power_washer/screen/home_screen.dart';
import 'package:power_washer/screen/notification_screen.dart';
import 'package:power_washer/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/my_request/my_request_data_bloc.dart';
import 'blocs/review/review_data_bloc.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final ApiService apiService = ApiService(); // Create an instance of ApiService

  runApp(MultiProvider(providers: [
    BlocProvider(
      create: (context) => HomePageBloc(apiService),
    ),
    BlocProvider(
      create: (context) => SearchBloc(apiService),
    ),
    BlocProvider(
      create: (context) => ServicePageBloc(apiService),
    ),
    BlocProvider(
      create: (context) => MyRequestPageBloc(apiService),
    ),
    BlocProvider(
      create: (context) => UserProfileBLoc(apiService),
    ),
    BlocProvider(
      create: (context) => ServiceDetailsBloc(apiService),
    ),
    BlocProvider(
      create: (context) => ReviewBloc(apiService),
    ),
    BlocProvider(
      create: (context) => NotificationBLoc(apiService),
    ),
  ], child: const MyApp()));
}
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showNotification(message);
}

void showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id', 'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: message.data['payload'],
  );
}

Future<void> selectNotification(NotificationResponse response) async {
  final String? payload = response.payload;
  print('Notification payload in selectNotification: $payload'); // Debug statement
  if (payload != null) {
    handleNavigation(payload);
  }
}

void handleNavigation(String payload) {
  if (payload == 'notifications') {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => NotificationScreen()),
          (Route<dynamic> route) => false,
    );
  } else if (payload == 'home') {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen(isSelectedBooking: 0)),
          (Route<dynamic> route) => false,
    );
  }
  // Add more conditions for other screens
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool isLoggedIn = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
   // initPreference();
    //getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification?.title}');
        print('Message also contained a notification: ${message.notification?.body}');
      }
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      _handleMessage(message);
    });

    messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

  }

  void _handleMessage(RemoteMessage message) {
    print('Handling message: ${message.data}'); // Debug statement
    handleNavigation(message.data['payload'] ?? '');
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Got Dirt',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}

