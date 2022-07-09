import 'package:chaturmail/controllers/ads_controller.dart';
import 'package:chaturmail/controllers/user_controller.dart';
import 'package:chaturmail/models/user_model.dart';
import 'package:chaturmail/utils/utils_controller.dart';
import 'package:chaturmail/view_models/past_emails_viewmodel.dart';
import 'package:chaturmail/view_models/prompt_viewmodel.dart';
import 'package:chaturmail/view_models/tutorials_viewmodel.dart';
import 'package:chaturmail/views/widgets/not_found_widget.dart';
import 'package:chaturmail/views/widgets/past_email_widget.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/constants.dart';
import '../widgets/dashboard_drawer.dart';
import '../widgets/generateEmailWidget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final promptController = Get.find<PromptController>();

  final pastEmailsController = Get.find<PastEmailsController>();

  final userController = Get.find<UserController>();

  final adsController = Get.find<AdsController>();

  late UserModel user;

  BannerAd? bannerAdMiddle;
  BannerAd? bannerAdBottom;

  @override
  void initState() {
    if (!didItOnce) {
      Future.wait([
        promptController.getPrompts(),
        pastEmailsController.getPastEmails(),
        Get.find<TutorialsController>().getTutorials(),
        Get.find<UserController>().getUserData(),
        Get.find<UserController>().getBannerUrl()
      ]);
    }

    didItOnce = true;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Get.find<UtilsController>().bottomNavBarIndex.value = 0;

    adsController.initialization.value.then((value) {
      setState(() {
        bannerAdMiddle = BannerAd(
            adUnitId: adsController.dashboardMiddleBannerUnitId,
            size: AdSize.banner,
            request: const AdRequest(),
            listener: adsController.bannerAdListener)
          ..load();
        bannerAdBottom = BannerAd(
            adUnitId: adsController.dashboardBottomBannerUnitId,
            size: AdSize.banner,
            request: const AdRequest(),
            listener: adsController.bannerAdListener)
          ..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DashboardDrawer(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: Get.find<UserController>().user.value != null
                    ? NetworkImage(
                        Get.find<UserController>().user.value!.picture)
                    : const AssetImage("assets/images/app_logo.png")
                        as ImageProvider,
                backgroundColor: mainColor,
              ),
            )
          ],
          elevation: 0,
        ),
        bottomNavigationBar: Get.find<UtilsController>().bottomNavBarWidget,
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<UtilsController>().initializeUtils();

            promptController.getPrompts();

            pastEmailsController.getPastEmails();

            Get.find<TutorialsController>().getTutorials();
          },
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          backgroundColor: greenMainColor2,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Generate Emails Heading
                  const Text(
                    "Generate Emails",
                    style: TextStyle(
                        color: Color.fromRGBO(187, 187, 187, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),

                  //Generate Emails Listview
                  Obx(() {
                    if (promptController.promptsLoading.value == true) {
                      return const Center(
                          child: Center(child: LoadingWidget()));
                      // return const CircularProgressIndicator(
                      //     color: greenMainColor2);
                    }

                    if (promptController.noPromptsFound.value == true) {
                      return const NotFoundWidget(
                        heading: "No Prompts Found",
                        message: "Please try again later",
                        tooltip: "So Sad...",
                      );
                    }

                    return SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return GenerateEmailWidget(
                              promptModel: promptController.promptsList[index],
                            );
                          },
                          itemCount: promptController.promptsList.length,
                          scrollDirection: Axis.horizontal,
                        ));
                  }),

                  //Gap
                  if (bannerAdBottom == null)
                    const SizedBox(height: 100)
                  else
                    SizedBox(
                      height: 100,
                      child: AdWidget(ad: bannerAdBottom!),
                    ),

                  //Past Emails Heading
                  const Text(
                    "Past Emails",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: greenMainColor2,
                        fontSize: 16),
                  ),

                  //Past Emails ListView
                  Obx(() {
                    if (pastEmailsController.pastEmailsLoading.value == true) {
                      return const Center(child: LoadingWidget());

                      // return const CircularProgressIndicator(
                      //     color: greenMainColor2);
                    }

                    if (pastEmailsController.noPastEmailsFound.value == true) {
                      return const NotFoundWidget(
                        heading: "No Past Emails Found",
                        message: "Please generate some emails",
                        tooltip: "Let's goo...",
                      );
                    }

                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          // print(pastEmailsController.pastEmailsList[index]);

                          return PastEmailWidget(
                            pastEmail:
                                pastEmailsController.pastEmailsList[index],
                          );
                        },
                        itemCount: pastEmailsController.pastEmailsList.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }),

                  //Ad
                  if (bannerAdMiddle == null)
                    const SizedBox(height: 50)
                  else
                    SizedBox(
                      height: 50,
                      child: AdWidget(ad: bannerAdMiddle!),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 11.96;

    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, 35, size.width - 45, 35);
    path.lineTo(45, 35);
    path.quadraticBezierTo(0, 35, 0, 0);
    path.close();

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/loading2.gif",
      width: 200,
      height: 200,
    );
  }
}
