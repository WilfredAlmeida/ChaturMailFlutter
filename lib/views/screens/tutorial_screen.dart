import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:wilfredemail/utils/constants.dart';

import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:wilfredemail/view_models/tutorials_viewmodel.dart';
import 'package:wilfredemail/views/widgets/tutorial_detail_widget.dart';

import '../widgets/bottom_navbar_widget.dart';
import '../widgets/not_found_widget.dart';

class TutorialsScreen extends StatelessWidget {
  TutorialsScreen({Key? key}) : super(key: key);

  final tutorialsController = Get.find<TutorialsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBarWidget(),
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
          child: Obx(() {
            if (tutorialsController.tutorialsLoading.value == true) {
              return const CircularProgressIndicator();
            }

            if (tutorialsController.noTutorialsFound.value == true) {
              return const NotFoundWidget(
                heading: "No Tutorials Found",
                message: "Please try again later",
                tooltip: "So Sad...",
              );
            }

            return ListView.builder(
              itemBuilder: (_, index) {
                bool curvePosition = (index % 2) == 0;

                return TutorialDetailWidget(
                  title: tutorialsController.tutorialsList[index].title,
                  htmlData:
                      tutorialsController.tutorialsList[index].htmlContent,
                  curvePosition: curvePosition,
                );
              },
              itemCount: tutorialsController.tutorialsList.length,
              scrollDirection: Axis.vertical,
            );
          }),
        ),
      ),
    );
  }
}
