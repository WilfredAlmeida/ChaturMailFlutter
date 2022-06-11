import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'jwt_token_obtainer.dart';
import 'storage_controller.dart';

class GoogleLoginController extends GetxController {
  Rx<GoogleSignIn> googleSignIn = GoogleSignIn().obs;

  Rx<GoogleSignInAccount>? user;

  Future<bool> googleLogin() async {
    final googleUser = await googleSignIn.value.signIn();

    print(googleUser);

    if (googleUser == null) {
      return false;
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    user = googleUser.obs;

    final sharedPreferencesController = Get.find<SharedPreferencesController>();

    var prefs = sharedPreferencesController.sharedPreferences.value;

    prefs.clear();

    prefs.setString(
      "user",
      jsonEncode({
        "displayName": googleUser.displayName,
        "email": googleUser.email,
        "id": googleUser.id,
        "photoUrl": googleUser.photoUrl,
        "serverAuthCode": googleUser.serverAuthCode
      }),
    );

    prefs.setString("loginMethod", "google");

    await Get.find<JWTController>().getJWTToken();

    return true;
  }

  Future<bool> googleLogout() async {
    var usr = googleSignIn.value.signOut();

    if (usr == null) {
      return true;
    }

    return false;
  }
}

/*

{
displayName: Clash Royal,
email: hi@hi.com,
id: 113759868300824793373,
photoUrl: https://lh3.googleusercontent.com/a/AATXAJyYS61M2JVYrU684bKrsVs3_LUQD3uK9Z90H2ou=s96-c, serverAuthCode: 4/0AX4XfWhJVxjeS-Ctrf5m2Hbov8UzOKAEnUMz0KBJ26xzWUFYwezdus37FKyKBuXKM8PmLw
}

*/
