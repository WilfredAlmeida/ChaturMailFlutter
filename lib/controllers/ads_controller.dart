import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController extends GetxController{

  late Rx<Future<InitializationStatus>> initialization;

  String get dashboardMiddleBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get dashboardBottomBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get tutorialsBottomBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get tutorialsDetailBottomBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get profileBottomBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get generateEmailBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get showGeneratedEmailBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get contactUsTopEmailBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  String get contactUsBottomBannerUnitId => Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'';

  BannerAdListener get bannerAdListener => const BannerAdListener();

}