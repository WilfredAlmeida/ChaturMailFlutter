import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilfredemail/controllers/google_login.dart';
import 'package:wilfredemail/utils/constants.dart';
import 'package:wilfredemail/views/screens/login_screen.dart';
import 'package:wilfredemail/views/screens/tutorial_screen.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: mainColor,
      child: Column(
        children: [
          Image.asset(
            "assets/images/banner.jpg",
            width: MediaQuery.of(context).size.width,
            height: 400,
          ),

          //Tutorials
          ListTile(
            onTap: () {
              Get.to(()=>TutorialsScreen());
            },
            tileColor: greenMainColor,
            leading: const Icon(
              Icons.help_outlined,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              "Tutorials",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),

          const Divider(),

          //Logout
          ListTile(
            onTap: () {
              Get.defaultDialog(
                  title: "Are you sure?",
                  middleText: "This will log you out of the application",
                  textCancel: "Cancel",
                  textConfirm: "Logout",
                  backgroundColor: greenMainColor,
                  buttonColor: mainColor,
                  confirmTextColor: Colors.white,
                  cancelTextColor: mainColor,
                  onConfirm: () async {
                    await Get.find<GoogleLoginController>().googleLogout();
                    Get.offAll(() => const LoginScreen());
                  });
            },
            tileColor: greenMainColor,
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),



        ],
      ),
    );
  }
}
