import 'package:get/get.dart';
import 'package:wilfredemail/views/screens/dashboard.dart';
import 'package:wilfredemail/views/screens/login_screen.dart';
import 'package:wilfredemail/views/screens/profile_screen.dart';
import 'package:wilfredemail/views/screens/tutorial_screen.dart';

class RoutesClass {
  static const String _dashboardRoute = "/dashboardScreen";
  static const String _displayGeneratedEmailRoute =
      "/displayGeneratedEmailScreen";
  static const String _generateEmailRoute = "/generateEmailScreen";
  static const String _loginRoute = "/loginScreenScreen";
  static const String _profileRoute = "/profileScreen";
  static const String _tutorialDetailRoute = "/tutorialDetailScreen";
  static const String _tutorialRoute = "/tutorialScreen";

  static String get dashboardRoute => _dashboardRoute;

  static String get displayGeneratedEmailRoute => _displayGeneratedEmailRoute;

  static String get generateEmailRoute => _generateEmailRoute;

  static String get loginRoute => _loginRoute;

  static String get profileRoute => _profileRoute;

  static String get tutorialDetailRoute => _tutorialDetailRoute;

  static String get tutorialRoute => _tutorialRoute;

  static List<GetPage> routes = [
    GetPage(name: _dashboardRoute, page: () => const DashboardScreen()),
    GetPage(name: _loginRoute, page: () => const LoginScreen()),
    GetPage(name: _profileRoute, page: () => ProfileScreen()),
    GetPage(name: _tutorialRoute, page: () => TutorialsScreen()),
  ];
}
