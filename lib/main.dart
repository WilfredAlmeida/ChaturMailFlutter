import 'package:chaturmail/controllers/ads_controller.dart';
import 'package:chaturmail/controllers/user_controller.dart';
import 'package:chaturmail/models/tutorials_model.dart';
import 'package:chaturmail/view_models/tutorials_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './models/past_emails_model.dart';
import './models/prompts_model.dart';
import './utils/utils_controller.dart';
import './view_models/prompt_viewmodel.dart';
import './views/screens/login_screen.dart';
import 'controllers/google_login.dart';
import 'controllers/jwt_token_obtainer.dart';
import 'controllers/login_checker.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';
import 'utils/constants.dart';
import 'utils/routes_class.dart';
import 'view_models/generate_email_viewmodel.dart';
import 'view_models/past_emails_viewmodel.dart';
import 'views/screens/dashboard.dart';

//Notification Channel
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

//For issuing local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//Handles notification when app is in background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //Start showing splash screen and begin initializations
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await _initialize();

  //Initializations done, remove splash screen
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

Future<void> _initialize() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Handles notification when app is in background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Initialize notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  //Hive initialization
  await Hive.initFlutter();

  //Registering hive adapters
  Hive.registerAdapter(PromptModelAdapter());
  Hive.registerAdapter(PastEmailsModelAdapter());
  Hive.registerAdapter(TutorialsModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  //Below are all hive boxes and GetX Controller initializations

  final promptController = Get.put(PromptController());

  final pastEmailsController = Get.put(PastEmailsController());

  final utilsController = Get.put(UtilsController());

  final tutorialsController = Get.put(TutorialsController());

  final adsController = Get.put(AdsController());

  //Ads instance initialization
  final initFuture = MobileAds.instance.initialize();
  adsController.initialization = initFuture.obs;

  var userController = Get.put(UserController());

  Get.put(GoogleLoginController());
  Get.put(JWTController());
  Get.put(GenerateEmailController());

  userController.userBox = (await Hive.openBox("userBox"));

  utilsController.initializeUtils();

  promptController.promptsBox = (await Hive.openBox("promptsBox"));

  pastEmailsController.pastEmailsBox = (await Hive.openBox("pastEmailsBox"));

  tutorialsController.tutorialsBox = (await Hive.openBox("tutorialsBox"));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future? userLoggedInFuture;

  @override
  void initState() {
    userLoggedInFuture = isUserLoggedIn();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher.png',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         title: Text(notification.title!),
        //         content: SingleChildScrollView(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [Text(notification.body!)],
        //           ),
        //         ),
        //       );
        //     });
      }
    });

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: RoutesClass.dashboardRoute,
      getPages: RoutesClass.routes,
      title: 'ChaturMail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: mainColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: mainColor,
          ),
          fontFamily: "Poppins"),
      home: FutureBuilder(
        future: userLoggedInFuture,
        builder: (c, r) {
          bool isLoggedIn = r.data == null ? false : r.data as bool;

          // return const SplashScreen();

          if (isLoggedIn) {
            return const DashboardScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
