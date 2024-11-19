import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/chat_screen_model.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/screens/home_screen.dart';
import 'package:flutter_chat_app/screens/sign_up_screen.dart';
import 'package:flutter_chat_app/services/firebase_option.dart';
import 'package:flutter_chat_app/services/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
 const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  PushNotificationService notificationHelper = PushNotificationService();
  @override

  void initState(){
    super.initState();
        FirebaseMessaging.instance.getToken().then((value) {
     var fcmToken = value;
      log("=====fcm token===$fcmToken===============");
    });
    notificationHelper.setupNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignupScreen(),
      routes: {
        '/login': (context) => SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/chat': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as ChatScreenModel;
          return ChatScreen(
            receiverEmail: args.email,
            receiverUserId: args.userId,
            receiveruserName: args.userName,
          );
        },
      },
    );
  }
}
