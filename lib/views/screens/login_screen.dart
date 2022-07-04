import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/google_login.dart';
import '../../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipPath(
                clipper: MyClipper1(),
                child: Container(
                  color: greenMainColor,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: mainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Login with Google
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: greenMainColor2,
                                  ),
                                );
                              });

                          final googleLoginController =
                              Get.find<GoogleLoginController>();

                          var loginSuccessful =
                              await googleLoginController.googleLogin();

                          if (loginSuccessful) {
                            Get.toNamed("/dashboardScreen");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            ImageIcon(
                              AssetImage("assets/images/google_icon.png"),
                              color: mainColor,
                              size: 30,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Login with Google",
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              greenMainColor,
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)))),
                      ),
                    ),

                    const SizedBox(height: 30),

                    //Info we get tooltip
                    Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration: const Duration(seconds: 6),
                      message:
                          "Google shares us your Name, Email, Picture. All used for your profile",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.info_outline,
                            color: greenMainColor2,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "information we get",
                            style: TextStyle(
                              color: greenMainColor2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    //Privacy Policy
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse(
                              "https://wilfredalmeida.github.io/ChaturMail-Privacy-Policy/"));
                        },
                        child: const Text(
                          "By continuing I accept the Privacy Policy. Tap to Read",
                          style: TextStyle(
                              color: greenMainColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    //Login with Apple
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.7,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: const [
                    //         ImageIcon(
                    //           AssetImage("assets/images/apple_icon.png"),
                    //           color: mainColor,
                    //           size: 30,
                    //         ),
                    //         SizedBox(width: 4),
                    //         Text(
                    //           "Login with Apple",
                    //           style: TextStyle(
                    //             color: mainColor,
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 18,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     style: ButtonStyle(
                    //         backgroundColor: MaterialStateProperty.all(
                    //           greenMainColor,
                    //         ),
                    //         padding: MaterialStateProperty.all(
                    //           const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    //         ),
                    //         shape: MaterialStateProperty.all(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(50)))),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    var pathHeight = size.height;
    var pathWidth = size.width;

    path.lineTo(0, pathHeight);

    var firstStartPoint =
        Offset(pathWidth / 4 - pathWidth / 8, pathHeight - 60);
    var firstEndPoint = Offset(pathWidth / 4 + pathWidth / 8, pathHeight - 70);
    path.quadraticBezierTo(
      firstStartPoint.dx,
      firstStartPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secStartPoint = Offset(pathWidth / 2, pathHeight - 70);
    var secEndPoint = Offset((pathWidth / 2 + pathWidth / 8), pathHeight - 50);
    path.quadraticBezierTo(
      secStartPoint.dx,
      secStartPoint.dy,
      secEndPoint.dx,
      secEndPoint.dy,
    );

    var tStartPoint =
        Offset(3 * (pathWidth / 4) + pathWidth / 8, pathHeight - 30);
    var tEndPoint = Offset(pathWidth, pathHeight - 90);
    path.quadraticBezierTo(
      tStartPoint.dx,
      tStartPoint.dy,
      tEndPoint.dx,
      tEndPoint.dy,
    );

    path.lineTo(pathWidth, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
