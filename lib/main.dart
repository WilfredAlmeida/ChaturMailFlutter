import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './models/prompts_model.dart';

import 'views/screens/dashboard.dart';
import 'views/screens/display_email_screen.dart';
import 'views/screens/generate_email_screen.dart';

void main() async{

  await Hive.initFlutter();

  Hive.registerAdapter(PromptModelAdapter());

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
      home: const DashboardScreen(),
    );
  }
}
