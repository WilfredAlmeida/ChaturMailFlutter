import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:wilfredemail/view_models/past_emails_viewmodel.dart';
import 'package:wilfredemail/view_models/prompt_viewmodel.dart';
import 'package:wilfredemail/views/widgets/not_found_widget.dart';
import 'package:wilfredemail/views/widgets/past_email_widget.dart';

import '../widgets/generateEmailWidget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final promptController = Get.put(PromptController());

  final pastEmailsController = Get.put(PastEmailsController());

  @override
  void initState(){
    promptController.getPrompts();

    pastEmailsController.getPastEmails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.verified_user),
            )
          ],
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: ()async{

            promptController.getPrompts();

            pastEmailsController.getPastEmails();

          },
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          backgroundColor: const Color.fromRGBO(37, 232, 138, 1),
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
                        color: Color.fromRGBO(37, 232, 138, 1),
                        fontSize: 16),
                  ),

                  //Generate Emails ListView
                  Obx((){

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

                          return PastEmailWidget(pastEmail: pastEmailsController.pastEmailsList[index],);
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
