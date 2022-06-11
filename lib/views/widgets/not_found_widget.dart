import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/utils_controller.dart';

class NotFoundWidget extends StatelessWidget {
  final heading;
  final message;
  final tooltip;

  const NotFoundWidget({
    Key? key,
    required this.heading,
    required this.message,
    required this.tooltip,
  }) : super(key: key);

  static const iconUrl =
      "https://img.icons8.com/ios-glyphs/30/000000/nothing-found.png";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            width: 200,
            height: 250,
            decoration: const BoxDecoration(
              color: greenMainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                  bottomRight: Radius.circular(22)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Get.find<UtilsController>().isInternetConnected.value
                    ? const ImageIcon(NetworkImage(iconUrl), size: 80)
                    : const ImageIcon(
                        AssetImage("assets/images/dizzy_face_icon.png"),
                        size: 80),
                Text(
                  heading,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: ""),
                ),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    overflow: TextOverflow.visible,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Align(
                    child: Text("😀🙂😐☹️"),
                    alignment: Alignment.bottomRight,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: greenMainColor2,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100))),
              child: Tooltip(
                message: tooltip,
                preferBelow: false,
                triggerMode: TooltipTriggerMode.tap,
                enableFeedback: true,
                showDuration: const Duration(seconds: 6),
                child: const Icon(Icons.timelapse_rounded, size: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
