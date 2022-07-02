import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wilfredemail/models/generate_email_request_model.dart';
import 'package:wilfredemail/models/generated_email_response_model.dart';
import 'package:wilfredemail/models/past_emails_model.dart';
import 'package:wilfredemail/models/prompts_model.dart';
import 'package:wilfredemail/view_models/past_emails_viewmodel.dart';

import '../../controllers/ads_controller.dart';
import '../../utils/constants.dart';
import '../../utils/utils_controller.dart';
import '../../view_models/generate_email_viewmodel.dart';
import '../widgets/bottom_navbar_widget.dart';
import 'display_email_screen.dart';

class GenerateEmailScreen extends StatefulWidget {
  @override
  State<GenerateEmailScreen> createState() => _GenerateEmailScreenState();

  final PromptModel promptModel;

  final PastEmailsModel? pastEmail;

  const GenerateEmailScreen(
      {Key? key, required this.promptModel, this.pastEmail})
      : super(key: key);
}

class _GenerateEmailScreenState extends State<GenerateEmailScreen> {
  // const GenerateEmailScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  // final _fromEmailInput = TextEditingController();

  final _toEmailInput = TextEditingController();

  final _subjectInput = TextEditingController();

  final _keywordsInput = TextEditingController();

  var _toEmailValid = true;

  // var _fromEmailValid = true;
  var _subjectValid = true;
  var _keywordsValid = true;

  final generateEmailController = Get.find<GenerateEmailController>();

  final adsController = Get.find<AdsController>();

  BannerAd? bannerAdBottom;

  InterstitialAd? intersitialAd;

  Function? _gotoNextScreen;

  @override
  void initState() {
    if (widget.pastEmail != null) {
      _toEmailInput.text = widget.pastEmail!.toEmailId;
      _subjectInput.text = widget.pastEmail!.subject;
      _keywordsInput.text = widget.pastEmail!.keywords;
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    adsController.initialization.value.then((value) {
      setState(() {
        bannerAdBottom = BannerAd(
          adUnitId: adsController.generateEmailBannerUnitId,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: adsController.bannerAdListener,
        )..load();

        InterstitialAd.load(
          adUnitId: adsController.intersitialAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (ad) {
                intersitialAd = ad;

                intersitialAd!.fullScreenContentCallback =
                    FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (ad) {
                    //Ad shown and closed, going to next screen
                    _gotoNextScreen!();
                  },
                  onAdFailedToShowFullScreenContent: (ad, e) {
                    print(e);
                    //Ad showing failed, going to next screen
                    _gotoNextScreen!();
                  },
                );
              },
              onAdFailedToLoad: (e) => print(e)),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Get.find<UtilsController>().bottomNavBarWidget,
        // bottomNavigationBar: const BottomNavBarWidget(),
        appBar: AppBar(
          title: Text(
            "${widget.promptModel.title} Email",
            style: const TextStyle(color: greenMainColor2),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //To Email
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: Color.fromRGBO(213, 225, 218, 1),
                    ),
                    padding: const EdgeInsets.only(left: 8),
                    child: TextFormField(
                      controller: _toEmailInput,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: "To: xyz@example.com",
                        border: InputBorder.none,
                        suffixIcon: _toEmailValid
                            ? const SizedBox()
                            : const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  //Keywords
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: Color.fromRGBO(213, 225, 218, 1),
                    ),
                    padding: const EdgeInsets.only(left: 8),
                    child: TextFormField(
                      controller: _keywordsInput,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText:
                            "Keywords\nEnter comma (,) separated keywords/phrases that should be in the email.\nNote: comma (,) is necessary, without it, there might be incorrect results",
                        border: InputBorder.none,
                        suffixIcon: _keywordsValid
                            ? const SizedBox()
                            : const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //Tokens
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Coins: ${widget.promptModel.maxTokens}",
                      style: const TextStyle(
                        color: greenMainColor2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Obx(
                    () => generateEmailController.generatingEmail.value
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
                                  _toEmailValid =
                                      _validateEmail(_toEmailInput.text);
                                  // _fromEmailValid =
                                  // _validateEmail(_fromEmailInput.text);
                                  _keywordsValid =
                                      _keywordsInput.text.isNotEmpty;
                                  _subjectValid = _subjectInput.text.isNotEmpty;

                                  setState(() {});

                                  if (!_toEmailValid ||
                                      // !_fromEmailValid ||
                                      !_keywordsValid ||
                                      !_subjectValid) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Please Enter correct details"),
                                      ),
                                    );
                                    return;
                                  }

                                  if (_subjectInput.text.length < 10) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter a bigger subject"),
                                      ),
                                    );
                                    return;
                                  }

                                  if (_keywordsInput.text.split(",").length <
                                      4) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter more keywords"),
                                      ),
                                    );
                                    return;
                                  }

                                  final generateEmailRequestModel =
                                      GenerateEmailRequestModel(
                                    subject: _subjectInput.text,
                                    keywords: _keywordsInput.text,
                                    promptId: widget.promptModel.id,
                                    toEmail: _toEmailInput.text,
                                  );

                                  generateEmailController.generateEmailRequest
                                      .value = generateEmailRequestModel;

                                  await generateEmailController.generateEmail();

                                  processResponse();
                                },
                                child: const Text(
                                  "Generate",
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

                  const SizedBox(height: 50),

                  //Ad
                  if (bannerAdBottom == null)
                    const SizedBox(height: 50)
                  else
                    SizedBox(
                      height: 50,
                      child: AdWidget(ad: bannerAdBottom!),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validateEmail(String? value) {
    const _emailRegExp = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';

    if (value == null || value.isEmpty) {
      return false;
    }

    if (!RegExp(_emailRegExp).hasMatch(value)) {
      return false;
    }

    return true;
  }

  void processResponse() {
    if (generateEmailController.generatingEmailFailed.value) {
      Get.find<UtilsController>().showErrorDialog(
          title: "Error Occurred",
          content: "Please Try Again",
          onConfirm: null);

      return;
    }

    GeneratedEmailResponseModel generatedEmailResponse =
        generateEmailController.generatedEmailResponse.value;

    if (generatedEmailResponse.status != 1) {
      Get.find<UtilsController>().showErrorDialog(
          title: "Error Occurred",
          content: "Please Try Again",
          onConfirm: null);

      return;
    }

    GeneratedEmailResponseModel responseModel =
        generateEmailController.generatedEmailResponse.value;

    final generatedEmail = responseModel.payload[0];

    Get.find<PastEmailsController>().getPastEmails();

    //Function to go on next screen. Done like this cuz after intersitital ad is closed. And defined up here cuz below it'll throw undefined error. This function is written here cuz the next screen needs data that is only present here in this function.
    _gotoNextScreen=(){
      Get.to(() => DisplayEmailScreen(generatedEmail: generatedEmail));
    };

    if (intersitialAd == null) {
      _gotoNextScreen!();
    } else {
      intersitialAd!.show();
    }

  }
}
