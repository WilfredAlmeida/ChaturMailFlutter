import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilfredemail/controllers/google_login.dart';
import 'package:wilfredemail/utils/constants.dart';
import 'package:wilfredemail/views/screens/contact_screen.dart';
import 'package:wilfredemail/views/screens/login_screen.dart';
import 'package:wilfredemail/views/screens/tutorial_screen.dart';

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
              Get.to(() => TutorialsScreen());
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
              Get.to(ContactScreen());
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
