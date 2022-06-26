import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilfredemail/utils/utils_controller.dart';
import 'package:wilfredemail/views/screens/generate_email_screen.dart';

import '../../models/prompts_model.dart';
import '../../utils/constants.dart';

class GenerateEmailWidget extends StatelessWidget {
  final PromptModel promptModel;

  GenerateEmailWidget({Key? key, required this.promptModel}) : super(key: key);

  final utilsController = Get.find<UtilsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(GenerateEmailScreen(promptModel: promptModel));
            },
            child: Container(
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
                  utilsController.isInternetConnected.value
                      ? ImageIcon(NetworkImage(promptModel.iconUrl), size: 80)
                      : const ImageIcon(
                          AssetImage("assets/images/dizzy_face_icon.png"),
                          size: 80),
                  Text(
                    promptModel.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: ""),
                  ),
                  Text(
                    promptModel.shortDescription,
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      overflow: TextOverflow.visible,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Align(
                      child: Text("Coins: ${promptModel.maxTokens}"),
                      alignment: Alignment.bottomRight,
                    ),
                  )
                ],
              ),
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
                message: promptModel.description,
                preferBelow: false,
                triggerMode: TooltipTriggerMode.tap,
                enableFeedback: true,
                showDuration: const Duration(seconds: 6),
                child: const Icon(Icons.info, size: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
