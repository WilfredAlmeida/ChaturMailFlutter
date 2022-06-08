import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import './models/past_emails_model.dart';
import './utils/utils_controller.dart';
import './view_models/prompt_viewmodel.dart';
import './views/screens/login_screen.dart';
import './models/prompts_model.dart';

import 'controllers/google_login.dart';
import 'controllers/login_checker.dart';
import 'view_models/past_emails_viewmodel.dart';
import 'views/screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();

  Hive.registerAdapter(PromptModelAdapter());
  Hive.registerAdapter(PastEmailsModelAdapter());

  final promptController = Get.put(PromptController());

  final pastEmailsController = Get.put(PastEmailsController());

  final utilsController = Get.put(UtilsController());

  Get.put(GoogleLoginController());

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  utilsController.initializeUtils();

  promptController.promptsBox = (await Hive.openBox("promptsBox"));

  pastEmailsController.pastEmailsBox = (await Hive.openBox("pastEmailsBox"));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const mainColor = Color.fromRGBO(37, 64, 71, 1);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future? userLoggedInFuture;

  @override
  void initState() {

    userLoggedInFuture = isUserLoggedIn();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const MyApp()),
        GetPage(name: "/dashboardScreen", page: () => const DashboardScreen()),
      ],
      title: 'Wilfred Email',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(37, 64, 71, 1),
          appBarTheme: const AppBarTheme(
            backgroundColor: MyApp.mainColor,
          ),
          fontFamily: "Poppins"),
      home: FutureBuilder(
        future: userLoggedInFuture,
        builder: (c, r) {

          bool isLoggedIn = r.data == null ? false : r.data as bool;

          if (isLoggedIn) {
            return const DashboardScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
