///This is the past email widget on DashboardScreen. Data comes flow if API -> Hive DB -> List in View Model -> Listview.builder -> This widget
import 'package:chaturmail/utils/utils_controller.dart';
import 'package:chaturmail/view_models/past_emails_viewmodel.dart';
import 'package:chaturmail/views/screens/display_email_screen.dart';
import 'package:chaturmail/views/screens/generate_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/generated_email_response_model.dart';
import '../../models/past_emails_model.dart';
import '../../utils/constants.dart';
import '../../view_models/prompt_viewmodel.dart';

class PastEmailWidget extends StatelessWidget {
  final PastEmailsModel pastEmail;

  final promptController = Get.find<PromptController>();

  PastEmailWidget({Key? key, required this.pastEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          //Email
          GestureDetector(
            onTap: () {
              final email = Payload(
                id: pastEmail.id,
                userId: pastEmail.userId,
                promptId: pastEmail.promptId,
                subject: pastEmail.subject,
                keywords: pastEmail.keywords,
                generatedEmail: pastEmail.generatedEmail,
                toEmailId: pastEmail.toEmailId,
                createdOn: pastEmail.createdOn,
              );

              Get.to(
                () => DisplayEmailScreen(generatedEmail: email),
                transition: Transition.fade,
              );
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Email Type
                    Text(
                      promptController.getPromptById(pastEmail.promptId).title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    //Subject
                    Text(
                      pastEmail.subject,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 4,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    //Space Filler
                    const Spacer(),

                    //Tokens
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Align(
                        child: Text("Coins: 250"),
                        alignment: Alignment.bottomRight,
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          //Action Button
          Positioned(
            bottom: 10,
            child: GestureDetector(
              onLongPress: () {
                final promptController = Get.find<PromptController>();

                Get.to(
                  () => GenerateEmailScreen(
                    promptModel:
                        promptController.getPromptById(pastEmail.promptId),
                    pastEmail: pastEmail,
                  ),
                  transition: Transition.fade,
                );
              },
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
                child: const Tooltip(
                  message: "Long Press to Regenerate",
                  preferBelow: false,
                  triggerMode: TooltipTriggerMode.tap,
                  enableFeedback: true,
                  showDuration: Duration(seconds: 2),
                  child: Icon(Icons.cached, size: 30),
                ),
              ),
            ),
          ),

          //Delete Button
          Positioned(
            top: -5,
            right: -2,
            child: IconButton(
              icon: const Icon(Icons.cancel_rounded),
              onPressed: () {
                Get.defaultDialog(
                    title: "Are you sure?",
                    middleText: "This will delete the email forever",
                    textCancel: "Cancel",
                    textConfirm: "Delete",
                    backgroundColor: greenMainColor,
                    buttonColor: mainColor,
                    confirmTextColor: Colors.white,
                    cancelTextColor: mainColor,
                    onConfirm: () async {
                      var utilsController = Get.find<UtilsController>();

                      if (!await utilsController.hasNetwork()) {
                        utilsController.showErrorDialog(
                            title: "No Internet",
                            content: "Please try again",
                            onConfirm: null);
                        return;
                      }

                      Get.back();

                      Get.snackbar(
                        "Deleting Email",
                        "Your email will be deleted",
                        icon: const Icon(Icons.delete, color: Colors.white),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: greenMainColor,
                        borderRadius: 20,
                        margin: const EdgeInsets.all(15),
                        colorText: Colors.black,
                        duration: const Duration(seconds: 1),
                        isDismissible: true,
                        dismissDirection: DismissDirection.horizontal,
                      );
                      await Get.find<PastEmailsController>()
                          .deleteGeneratedEmail(
                        id: pastEmail.id,
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
