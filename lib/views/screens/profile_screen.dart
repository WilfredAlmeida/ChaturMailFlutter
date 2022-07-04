import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chaturmail/controllers/user_controller.dart';
import 'package:chaturmail/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controllers/ads_controller.dart';
import '../../models/user_model.dart';
import '../../utils/utils_controller.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = Get.find<UserController>().user.value == null
      ? null
      : Get.find<UserController>().user.value as UserModel;

  final adsController = Get.find<AdsController>();

  BannerAd? bannerAdBottom;

  @override
  void initState() {
    Get.find<UserController>().getUserData();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      bannerAdBottom = BannerAd(
        adUnitId: adsController.profileBottomBannerUnitId,
        size: AdSize.mediumRectangle,
        request: const AdRequest(),
        listener: adsController.bannerAdListener,
      )..load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Get.find<UtilsController>().bottomNavBarWidget,
        // bottomNavigationBar: const BottomNavBarWidget(),
        body: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: SingleChildScrollView(
                  child: user == null
                      ? const Text(
                          "Something Went Wrong 😀🙂😐☹",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: greenMainColor2,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Picture
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: CircleAvatar(
                                backgroundImage:
                                    CachedNetworkImageProvider(user!.picture),
                                radius: 50,
                              ),
                            ),

                            const SizedBox(height: 20),

                            //Name
                            MText(txt: user!.name),

                            //email
                            MText(txt: user!.email),

                            //coins used
                            MText(
                              txt: 'Coins Used: ${user!.usedTokens.toString()}',
                            ),

                            //coins available
                            MText(
                              txt:
                                  'Coins Available: ${user!.availableTokens.toString()}',
                            ),

                            // const SizedBox(height: 10),

                            //Banner
                            Get.find<UserController>()
                                    .bannerBase64
                                    .value
                                    .isEmpty
                                ? const SizedBox()
                                : Image.memory(
                                    base64Decode(Get.find<UserController>()
                                        .bannerBase64
                                        .value),
                                    width: 200,
                                    height: 180,
                                  ),
                          ],
                        ),
                ),
              ),
            ),

            //Ad
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 100,
                child: bannerAdBottom == null
                    ? const SizedBox()
                    : AdWidget(ad: bannerAdBottom!),
              ),
            )
          ],
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
