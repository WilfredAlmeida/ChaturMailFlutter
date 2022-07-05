import 'package:chaturmail/utils/constants.dart';
import 'package:chaturmail/view_models/tutorials_viewmodel.dart';
import 'package:chaturmail/views/widgets/tutorial_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controllers/ads_controller.dart';
import '../../utils/utils_controller.dart';
import '../widgets/not_found_widget.dart';

class TutorialsScreen extends StatefulWidget {
  TutorialsScreen({Key? key}) : super(key: key);

  @override
  State<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends State<TutorialsScreen> {
  final tutorialsController = Get.find<TutorialsController>();

  final adsController = Get.find<AdsController>();

  BannerAd? bottomAdBanner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      bottomAdBanner = BannerAd(
          adUnitId: adsController.tutorialsBottomBannerUnitId,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: adsController.bannerAdListener)
        ..load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Get.find<UtilsController>().bottomNavBarWidget,
        // bottomNavigationBar: const BottomNavBarWidget(),
        appBar: AppBar(
          title: const Text(
            "Tutorials",
            style: TextStyle(color: greenMainColor2),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await tutorialsController.getTutorials();
          },
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          backgroundColor: greenMainColor2,
          child: Stack(
            children: [
              Positioned.fill(
                child: Obx(() {
                  if (tutorialsController.tutorialsLoading.value == true) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: greenMainColor2,
                      ),
                    );
                  }

                  if (tutorialsController.noTutorialsFound.value == true) {
                    return const NotFoundWidget(
                      heading: "No Tutorials Found",
                      message: "Please try again later",
                      tooltip: "So Sad...",
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      bool curvePosition = (index % 2) == 0;

                      return TutorialDetailWidget(
                        title: tutorialsController.tutorialsList[index].title,
                        htmlData: tutorialsController
                            .tutorialsList[index].htmlContent,
                        curvePosition: curvePosition,
                      );
                    },
                    itemCount: tutorialsController.tutorialsList.length,
                    scrollDirection: Axis.vertical,
                  );
                }),
              ),

              //Ad
              Positioned(
                bottom: 1,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 50,
                  child: bottomAdBanner == null
                      ? const SizedBox()
                      : AdWidget(ad: bottomAdBanner!),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
