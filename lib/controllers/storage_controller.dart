import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController {
  late final Rx<SharedPreferences> sharedPreferences;

  Future<bool> initializeSharedPreference() async {
    final a = await SharedPreferences.getInstance();

    sharedPreferences = a.obs;

    return true;
  }
}
