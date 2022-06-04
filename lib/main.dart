import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import './models/past_emails_model.dart';
import './utils/utils_controller.dart';
import './view_models/prompt_viewmodel.dart';
import './views/screens/login_screen.dart';
import './models/prompts_model.dart';

import 'view_models/past_emails_viewmodel.dart';
import 'views/screens/dashboard.dart';
import 'views/screens/display_email_screen.dart';
import 'views/screens/generate_email_screen.dart';


void main() async{

  await Hive.initFlutter();

  Hive.registerAdapter(PromptModelAdapter());
  Hive.registerAdapter(PastEmailsModelAdapter());

  final promptController = Get.put(PromptController());

  final pastEmailsController = Get.put(PastEmailsController());

  final utilsController = Get.put(UtilsController());

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  utilsController.initializeUtils();

  promptController.promptsBox = (await Hive.openBox("promptsBox"));

  pastEmailsController.pastEmailsBox = (await Hive.openBox("pastEmailsBox"));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const mainColor=Color.fromRGBO(37, 64, 71, 1);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/",page: ()=>const MyApp()),
        GetPage(name: "/dashboardScreen",page: ()=>const DashboardScreen()),
      ],
      title: 'Wilfred Email',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(37, 64, 71, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: mainColor,
        ),
        fontFamily: "Poppins"
      ),
      home: const LoginScreen(),
    );
  }
}
