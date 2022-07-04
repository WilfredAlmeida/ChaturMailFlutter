import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chaturmail/utils/constants.dart';
import 'package:chaturmail/views/screens/tutorial_detail_screen.dart';

class TutorialDetailWidget extends StatelessWidget {
  final String htmlData;
  final String title;
  final bool curvePosition;

  const TutorialDetailWidget(
      {Key? key,
      required this.htmlData,
      required this.title,
      required this.curvePosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TutorialDetailScreen(title: title, htmlData: htmlData));
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: greenMainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: curvePosition
                      ? const Radius.circular(100)
                      : const Radius.circular(22),
                  topLeft: const Radius.circular(22),
                  topRight: const Radius.circular(22),
                  bottomRight: curvePosition
                      ? const Radius.circular(22)
                      : const Radius.circular(100),
                ),
                boxShadow: [
                  BoxShadow(
                    color: greenMainColor2.withOpacity(0.5),
                    blurRadius: 1.0,
                    spreadRadius: 1.5,
                    offset: curvePosition
                        ? const Offset(-2.0, -2.0)
                        : const Offset(2.0, 2.0),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
