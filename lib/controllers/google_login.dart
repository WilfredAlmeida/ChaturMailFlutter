import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleLoginController extends GetxController{

  Rx<GoogleSignIn> googleSignIn = GoogleSignIn().obs;


  Rx<GoogleSignInAccount>? user;

  Future<bool> googleLogin() async{

    final googleUser = await googleSignIn.value.signIn();

    print(googleUser);

    if(googleUser!=null){
      user = googleUser.obs;
      return true;
    }

    return false;
  }

  Future<bool> googleLogout() async{

    var usr = googleSignIn.value.signOut();

    if(usr==null){
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