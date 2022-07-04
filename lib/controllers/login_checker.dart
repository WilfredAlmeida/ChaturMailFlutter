import 'package:get/get.dart';
import 'package:chaturmail/controllers/google_login.dart';

Future<bool> isUserLoggedIn() async {
  final googleLoginController = Get.find<GoogleLoginController>();

  if (await googleLoginController.googleSignIn.value.isSignedIn()) {
    return true;
  }

  return false;
}
