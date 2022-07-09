import 'dart:io';

import 'package:chaturmail/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../screens/dashboard.dart';
import '../screens/tutorial_screen.dart';

class BottomNavBarWidget extends StatefulWidget {
  BottomNavBarWidget({Key? key}) : super(key: key);

  final RxInt currentIndex = 0.obs;

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
            title: "Do you want to Exit?",
            content: const Text("The app will be exited"),
            textConfirm: "No",
            textCancel: "Yes",
            buttonColor: mainColor.withOpacity(0.6),
            confirmTextColor: greenMainColor2,
            cancelTextColor: Colors.black,
            onConfirm: () {
              print("CONFIRMED");
              Get.back();
            },
            onCancel: () {
              print("CANCELLED");
              exit(0);
            });

        return true;
      },
      child: Obx(() => Stack(
            children: [
              Container(
                height: 65,
                color: mainColor,
                child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 100),
                    painter: MyPainter()),
              ),
              Positioned(
                bottom: 0,
                top: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.currentIndex.value = 0;
                        });

                        Get.offAll(() => const DashboardScreen());
                      },
                      icon: Icon(
                        Icons.home,
                        size: 30,
                        color: widget.currentIndex.value == 0
                            ? greenMainColor2
                            : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.currentIndex.value = 1;
                        });
                        Get.off(() => TutorialsScreen());
                      },
                      icon: Icon(
                        Icons.menu_book_outlined,
                        size: 30,
                        color: widget.currentIndex.value == 1
                            ? greenMainColor2
                            : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.currentIndex.value = 2;
                        });
                        Get.off(() => ProfileScreen());
                      },
                      icon: Icon(
                        Icons.person,
                        size: 30,
                        color: widget.currentIndex.value == 2
                            ? greenMainColor2
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 11.96;

    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, 35, size.width - 45, 35);
    path.lineTo(45, 35);
    path.quadraticBezierTo(0, 35, 0, 0);
    path.close();

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
