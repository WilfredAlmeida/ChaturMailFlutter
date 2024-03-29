//Shows the tutorial detail. Renders HTML received from server. Sending HTML makes tutorials customized. Otherwise having different formats for tutorials in flutter would be a pain
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controllers/ads_controller.dart';
import '../../utils/utils_controller.dart';

class TutorialDetailScreen extends StatefulWidget {
  const TutorialDetailScreen(
      {Key? key, required this.title, required this.htmlData})
      : super(key: key);

  final String title;

  //HTML in form of String that'll be parsed and rendered
  final String htmlData;

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  BannerAd? bottomBanner;

  final adsController = Get.find<AdsController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Get.find<UtilsController>().bottomNavBarIndex.value = 1;

    setState(() {
      bottomBanner = BannerAd(
        adUnitId: adsController.tutorialsDetailBottomBannerUnitId,
        size: AdSize.largeBanner,
        request: const AdRequest(),
        listener: adsController.bannerAdListener,
      )..load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //To get back on TutorialsScreen, if not done here it takes to DashboardScreen, that logic in onWillPop in BottomNavbarWidget
        Get.back();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Get.find<UtilsController>().bottomNavBarWidget,
          // bottomNavigationBar: const BottomNavBarWidget(),
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Html(
                  data: widget.htmlData,
                ),
              ),

              //Ad
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 100,
                  child: bottomBanner == null
                      ? const SizedBox()
                      : AdWidget(ad: bottomBanner!),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
