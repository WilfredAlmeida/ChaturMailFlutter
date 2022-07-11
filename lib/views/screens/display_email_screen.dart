//This screen displays generated email
import 'package:chaturmail/models/generated_email_response_model.dart';
import 'package:chaturmail/view_models/prompt_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/ads_controller.dart';
import '../../utils/constants.dart';
import '../../utils/utils_controller.dart';

class DisplayEmailScreen extends StatefulWidget {
  //Generated email object
  final Payload generatedEmail;

  late final String _promptName;

  DisplayEmailScreen({Key? key, required this.generatedEmail}) {
    _promptName = Get.find<PromptController>()
        .getPromptById(generatedEmail.promptId)
        .title;
  }

  static const _headingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: greenMainColor2,
  );

  static const _contentStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(213, 225, 218, 1),
  );

  @override
  State<DisplayEmailScreen> createState() => _DisplayEmailScreenState();
}

class _DisplayEmailScreenState extends State<DisplayEmailScreen> {
  final adsController = Get.find<AdsController>();

  BannerAd? bannerAdBottom;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Get.find<UtilsController>().bottomNavBarIndex.value = 0;

    adsController.initialization.value.then((value) {
      setState(() {
        bannerAdBottom = BannerAd(
          adUnitId: adsController.showGeneratedEmailBannerUnitId,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: adsController.bannerAdListener,
        )..load();
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
          title: Text(widget._promptName),
          elevation: 0,
        ),

        //Launches email app like gmail
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            launchEmailApp(
              widget.generatedEmail.toEmailId,
              "",
              widget.generatedEmail.subject,
              widget.generatedEmail.generatedEmail,
            );
          },
          backgroundColor: greenMainColor2,
          child: const Icon(Icons.email_rounded, color: Colors.black, size: 35),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //To Email Heading
                const Text("To:", style: DisplayEmailScreen._headingStyle),

                //To Email Content
                Text(widget.generatedEmail.toEmailId,
                    style: DisplayEmailScreen._contentStyle),

                const SizedBox(height: 15),

                //Subject Heading
                const Text("Subject:", style: DisplayEmailScreen._headingStyle),

                //Subject Content
                Text(widget.generatedEmail.subject,
                    style: DisplayEmailScreen._contentStyle),

                const SizedBox(height: 15),

                //Keywords Heading
                const Text("Keywords:",
                    style: DisplayEmailScreen._headingStyle),

                //Keywords Content
                Text(widget.generatedEmail.keywords,
                    style: DisplayEmailScreen._contentStyle),

                const SizedBox(height: 15),

                //Generated Email Heading & Copy to Clipboard button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Generated Email:",
                        style: DisplayEmailScreen._headingStyle),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: widget.generatedEmail.generatedEmail));
                        Get.snackbar(
                          "Copied",
                          "Copied to Clipboard",
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
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: greenMainColor2,
                      ),
                    )
                  ],
                ),

                //Generated Email Content
                Text(widget.generatedEmail.generatedEmail,
                    style: DisplayEmailScreen._contentStyle),

                const SizedBox(height: 15),

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
    );
  }

  void launchEmailApp(to, from, subject, body) async {
    final url = Uri.parse(
        'mailto:$to?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}');

    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }
}
