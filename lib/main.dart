import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/utils/theme.dart';
import 'screens/login/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void initInfo() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
      defaultActionName: 'Open notification');
  const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(

  );
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      linux: initializationSettingsLinux,
      iOS: initializationSettingsDarwin,
      
  );


  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  //foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    var body = jsonDecode(message.data['body']);
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      '${body['text']}', htmlFormatBigText: true,
      contentTitle: '<b>Tín nhắn từ ${message.data['fromFirstName']} ${message.data['fromLastName']}</b>', htmlFormatContentTitle: true,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('dbfood', 'dbfood', importance: Importance.high,
      styleInformation: bigTextStyleInformation, priority: Priority.high, playSound: true,
    );
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      

    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, 'this is title', 'this is body',
        notificationDetails, payload: 'this is payload'
    );
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
      defaultActionName: 'Open notification');
      const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      linux: initializationSettingsLinux,
      iOS: initializationSettingsDarwin
  );


  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  var body = jsonDecode(message.data['body']);
  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    '${body['text']}', htmlFormatBigText: true, htmlFormatTitle: true,
    contentTitle: '<b>Tín nhắn từ ${message.data['fromFirstName']} ${message.data['fromLastName']}</b>', htmlFormatContentTitle: true,
  );

  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('dbfood', 'dbfood', importance: Importance.high,
    styleInformation: bigTextStyleInformation, priority: Priority.high, playSound: true,
  );
 DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();
  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);

  await flutterLocalNotificationsPlugin.show(0, 'Zee Home', 'Bạn có tin nhắn mới',
      notificationDetails, payload: 'this is payload'
  );
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }


  print("Handling a background message: ${message.messageId}");
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('fcm_token', value.toString());
    });
  });

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  requestPermission();
  initInfo();

  // background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => HouseProvider()),
      ChangeNotifierProvider(create: (_) => ChatModel()),
    ], child: MaterialApp(
      theme: lightTheme(context),
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      builder: EasyLoading.init(),
    ));
  }
}


