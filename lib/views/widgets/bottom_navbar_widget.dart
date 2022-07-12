//Bottom navigation bar widget. Is a stack placed at bottom of all screens
import 'package:chaturmail/utils/utils_controller.dart';
import 'package:chaturmail/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../screens/dashboard.dart';
import '../screens/tutorial_screen.dart';

class BottomNavBarWidget extends StatefulWidget {
  BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  final utilsController = Get.find<UtilsController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //If not on DashboardScreen, get there. Else exit the app.
        if (utilsController.bottomNavBarIndex.value != 0) {
          Get.offAll(
            const DashboardScreen(),
            transition: Transition.fade,
          );
          return false;
        }

        return true;
      },
      child: Stack(
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
                    // setState(() {
                    // utilsController.bottomNavBarIndex.value = 0;
                    // });

                    Get.offAll(
                      () => const DashboardScreen(),
                      transition: Transition.fade,
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: utilsController.bottomNavBarIndex.value == 0
                        ? greenMainColor2
                        : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // setState(() {
                    // utilsController.bottomNavBarIndex.value = 1;
                    // });
                    Get.off(
                      () => TutorialsScreen(),
                      transition: Transition.fade,
                    );
                  },
                  icon: Icon(
                    Icons.menu_book_outlined,
                    size: 30,
                    color: utilsController.bottomNavBarIndex.value == 1
                        ? greenMainColor2
                        : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // setState(() {
                    // utilsController.bottomNavBarIndex.value = 2;
                    // });
                    Get.off(
                      () => ProfileScreen(),
                      transition: Transition.fade,
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: utilsController.bottomNavBarIndex.value == 2
                        ? greenMainColor2
                        : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//The curves at top left and top right
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
