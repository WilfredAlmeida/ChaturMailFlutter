import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilfredemail/views/screens/display_email_screen.dart';
import 'package:wilfredemail/views/screens/generate_email_screen.dart';
import '../../models/past_emails_model.dart';
import '../../utils/constants.dart';
import '../../view_models/prompt_viewmodel.dart';
import '../../models/generated_email_response_model.dart';

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

              Get.to(() => DisplayEmailScreen(generatedEmail: email));
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
                        child: Text("Tokens: 250"),
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

                Get.to(() => GenerateEmailScreen(
                      promptModel:
                          promptController.getPromptById(pastEmail.promptId),
                      pastEmail: pastEmail,
                    ));
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
          )
        ],
      ),
    );
  }
}
