import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:wilfredemail/controllers/user_controller.dart';
import 'package:wilfredemail/models/user_model.dart';
import 'package:wilfredemail/utils/utils_controller.dart';
import 'package:wilfredemail/view_models/past_emails_viewmodel.dart';
import 'package:wilfredemail/view_models/prompt_viewmodel.dart';
import 'package:wilfredemail/view_models/tutorials_viewmodel.dart';
import 'package:wilfredemail/views/screens/tutorial_screen.dart';
import 'package:wilfredemail/views/widgets/bottom_navbar_widget.dart';
import 'package:wilfredemail/views/widgets/not_found_widget.dart';
import 'package:wilfredemail/views/widgets/past_email_widget.dart';

import '../../controllers/google_login.dart';
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

  late UserModel user;

  @override
  void initState() {
    if (!didItOnce) {
      Future.wait([
        promptController.getPrompts(),
        pastEmailsController.getPastEmails(),
        Get.find<TutorialsController>().getTutorials(),
        Get.find<UserController>().getUserData()
      ]);
    }

    didItOnce = true;

    super.initState();
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
                backgroundImage: Get.find<UserController>().user.value!=null
                    ? NetworkImage(
                        Get.find<UserController>().user.value!.picture)
                    : const AssetImage("assets/images/app_logo.png") as ImageProvider,
                backgroundColor: mainColor,
              ),
            )
          ],
          elevation: 0,
        ),
        bottomNavigationBar: const BottomNavBarWidget(),
        // bottomNavigationBar: Stack(
        //   children: [
        //     Container(
        //       height: 65,
        //       color: mainColor,
        //       child: CustomPaint(
        //           size: Size(MediaQuery.of(context).size.width, 100),
        //           painter: MyPainter()),
        //     ),
        //     Positioned(
        //       bottom: 0,
        //       top: 30,
        //       width: MediaQuery.of(context).size.width,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //           IconButton(
        //             onPressed: () {
        //               setState(() {
        //                 _currentIndex = 0;
        //               });
        //
        //               Get.offAll(()=>const DashboardScreen());
        //
        //             },
        //             icon: Icon(
        //               Icons.home,
        //               size: 30,
        //               color:
        //                   _currentIndex == 0 ? greenMainColor2 : Colors.white,
        //             ),
        //           ),
        //           IconButton(
        //             onPressed: () {
        //               setState(() {
        //                 _currentIndex = 1;
        //               });
        //               Get.to(()=>TutorialsScreen());
        //             },
        //             icon: Icon(
        //               Icons.menu_book_outlined,
        //               size: 30,
        //               color:
        //                   _currentIndex == 1 ? greenMainColor2 : Colors.white,
        //             ),
        //           ),
        //           IconButton(
        //             onPressed: () {
        //               setState(() {
        //                 _currentIndex = 2;
        //               });
        //               Get.to(()=>TutorialsScreen());
        //             },
        //             icon: Icon(
        //               Icons.person,
        //               size: 30,
        //               color:
        //                   _currentIndex == 2 ? greenMainColor2 : Colors.white,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
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
                      return const CircularProgressIndicator();
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
                  const SizedBox(height: 100),

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
                      return const CircularProgressIndicator();
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
