import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilfredemail/utils/utils_controller.dart';

import '../../utils/constants.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key? key}) : super(key: key);

  final _subjectInput = TextEditingController();
  final _bodyInput = TextEditingController();

  final _subjectValid = true;
  final _bodyValid = true;

  final utilsController = Get.find<UtilsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              //Subject
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  color: Color.fromRGBO(213, 225, 218, 1),
                ),
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  controller: _subjectInput,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Subject",
                    border: InputBorder.none,
                    suffixIcon: _subjectValid
                        ? const SizedBox()
                        : const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //Body
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  color: Color.fromRGBO(213, 225, 218, 1),
                ),
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  controller: _bodyInput,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText:
                    "Enter your Message",
                    border: InputBorder.none,
                    suffixIcon: _bodyValid
                        ? const SizedBox()
                        : const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),

              const SizedBox(height: 20),


              Obx(
                    () => utilsController.submittingFeedback.value
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: greenMainColor2,
                  ),
                )
                    : //Submit Button
                Center(
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22)),
                    child: ElevatedButton(
                      onPressed: () async {


                        if(_subjectInput.text.isEmpty||_bodyInput.text.isEmpty||_subjectInput.text.length<10||_bodyInput.text.length<10){
                          showSnackbar("Invalid Values","Enter more than 10 characters in all fields");
                          return;
                        }


                       utilsController.submitFeedback(subject: _subjectInput.text, message: _bodyInput.text);
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: mainColor,
                          fontSize: 16,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(213, 225, 218, 1),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(String title, String message){
    Get.snackbar(
      title,
      message,
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
  }

}
