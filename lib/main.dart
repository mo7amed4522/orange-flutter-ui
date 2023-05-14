import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/screen/chat_screen/view_model/chat_screen_view_model.dart';
import 'package:orange_ui/screen/get_started_screen/get_started_screen.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // Status bar color
    statusBarColor: ColorRes.transparent,
    // Status bar brightness (optional)
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light, // For iOS (dark icons)
  ));
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Locale _locale = const Locale('en');

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    saveTokenUpdate();
    super.initState();
  }

  void saveTokenUpdate() async {
    await FirebaseMessaging.instance.subscribeToTopic("Orange");
    await FirebaseMessaging.instance.getToken();

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'Helnay', // id
      'Helnay', // title
      playSound: true,
      description: 'Helnay',
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
    );
    FirebaseMessaging.instance.subscribeToTopic(ConstRes.aTopicName);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        var initializationSettingsAndroid =
            const AndroidInitializationSettings('@mipmap/ic_launcher');
        var initializationSettingsIOS = const IOSInitializationSettings();
        var initializationSettings = InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
        FlutterLocalNotificationsPlugin().initialize(initializationSettings);
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? apple = message.notification?.apple;

        if (notification != null &&
            apple != null &&
            !ChatScreenViewModel.isScreen) {
          flutterLocalNotificationsPlugin.show(
            12,
            notification.title,
            notification.body,
            const NotificationDetails(
              iOS: IOSNotificationDetails(
                presentSound: true,
              ),
            ),
          );
        }

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null &&
            android != null &&
            !ChatScreenViewModel.isScreen) {
          flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id, channel.name,
                channelDescription: channel.description,
                // other properties...
              ),
            ),
          );
        }
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Helnay',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      supportedLocales: [
        _locale, // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: FontRes.regular,
        primaryColor: ColorRes.orange,
      ),
      home: const GetStartedScreen(),
    );
  }
}
