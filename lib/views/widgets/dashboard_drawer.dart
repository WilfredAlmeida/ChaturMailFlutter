import 'dart:convert';

import 'package:chaturmail/controllers/google_login.dart';
import 'package:chaturmail/utils/constants.dart';
import 'package:chaturmail/views/screens/contact_screen.dart';
import 'package:chaturmail/views/screens/login_screen.dart';
import 'package:chaturmail/views/screens/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/user_controller.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: mainColor,
      child: Column(
        children: [
          //Banner
          Get.find<UserController>().bannerBase64.value.isEmpty
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                )
              : Image.memory(
                  base64Decode(Get.find<UserController>().bannerBase64.value),
                  width: 300,
                  height: 300,
                ),

          //Tutorials
          ListTile(
            onTap: () {
              Get.to(
                () => TutorialsScreen(),
                transition: Transition.fade,
              );
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

          //Contact
          ListTile(
            onTap: () {
              Get.to(
                ContactScreen(),
                transition: Transition.fade,
              );
            },
            tileColor: greenMainColor,
            leading: const Icon(
              Icons.contact_page_outlined,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),

          const Divider(),

          //Logout
          ListTile(
            onTap: () {
              Get.defaultDialog(
                  title: "Are you sure?",
                  middleText:
                      "This will log you out of the application and close the app",
                  textCancel: "Cancel",
                  textConfirm: "Logout",
                  backgroundColor: greenMainColor,
                  buttonColor: mainColor,
                  confirmTextColor: Colors.white,
                  cancelTextColor: mainColor,
                  onConfirm: () async {
                    await Get.find<GoogleLoginController>().googleLogout();
                    Get.offAll(
                      () => const LoginScreen(),
                      transition: Transition.fade,
                    );
                    SystemNavigator.pop();
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

          const Divider(),

          //Delete
          ListTile(
            onTap: () {
              Get.defaultDialog(
                  title: "Are you sure?",
                  middleText:
                      "This will delete your profile and emails and close the app",
                  textCancel: "Cancel",
                  textConfirm: "Delete",
                  backgroundColor: greenMainColor,
                  buttonColor: mainColor,
                  confirmTextColor: Colors.white,
                  cancelTextColor: mainColor,
                  onConfirm: () async {
                    await Get.find<UserController>().deleteUser();
                    Get.offAll(
                      () => const LoginScreen(),
                      transition: Transition.fade,
                    );
                    SystemNavigator.pop();
                  });
            },
            tileColor: greenMainColor,
            leading: const Icon(
              Icons.delete_forever,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              "Delete",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),

          const Divider(),

          //Privacy Policy
          ListTile(
            onTap: () {
              launchUrl(Uri.parse(
                  "https://wilfredalmeida.github.io/ChaturMail-Privacy-Policy/"));
            },
            tileColor: greenMainColor,
            leading: const Icon(
              Icons.privacy_tip,
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              "Privacy Policy",
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
