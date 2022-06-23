import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilfredemail/controllers/user_controller.dart';
import 'package:wilfredemail/utils/constants.dart';
import 'package:wilfredemail/views/widgets/bottom_navbar_widget.dart';

import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final UserModel user = Get.find<UserController>().user.value as UserModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBarWidget(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //Picture
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(user.picture),
                    radius: 50,
                  ),
                ),

                const SizedBox(height: 20),

                //Name
                MText(txt: user.name),

                //email
                MText(txt: user.email),

                //coins used
                MText(
                  txt: 'Coins Used: ${user.usedTokens.toString()}',
                ),

                //coins available
                MText(
                  txt: 'Coins Available: ${user.availableTokens.toString()}',
                ),

                const SizedBox(height: 30),

                //Banner
                Get.find<UserController>().bannerBase64.value.isEmpty?const SizedBox():
                Image.memory(
                  base64Decode(Get.find<UserController>().bannerBase64.value),
                  width: 300,
                  height: 300,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MText extends StatelessWidget {
  const MText({Key? key, required this.txt}) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        txt,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: greenMainColor2,
        ),
      ),
    );
  }
}
