import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../utils/utils_controller.dart';
import '../widgets/bottom_navbar_widget.dart';

class TutorialDetailScreen extends StatelessWidget {
  const TutorialDetailScreen(
      {Key? key, required this.title, required this.htmlData})
      : super(key: key);

  final String title;
  final String htmlData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Get.find<UtilsController>().bottomNavBarWidget,
        // bottomNavigationBar: const BottomNavBarWidget(),
        appBar: AppBar(
          title: Text(title),
        ),
        body: Html(
          data: htmlData,
        ),
      ),
    );
  }
}
