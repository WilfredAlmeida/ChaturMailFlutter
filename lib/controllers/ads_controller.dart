//This file provides Google AdMob Ad Unit ID's via state management
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController extends GetxController {
  late Rx<Future<InitializationStatus>> initialization;

  String get dashboardMiddleBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/2954982508' : '';

  String get dashboardBottomBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/7907764580' : '';

  String get tutorialsBottomBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/3202232819' : '';

  String get tutorialsDetailBottomBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/1697579453' : '';

  String get profileBottomBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/2627517745' : '';

  String get generateEmailBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/6375191063' : '';

  String get showGeneratedEmailBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/1449349203' : '';

  String get contactUsTopEmailBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/7305129350' : '';

  String get contactUsBottomBannerUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/8420832107' : '';

  String get intersitialAdUnitId =>
      Platform.isAndroid ? 'ca-app-pub-6079539654362873/7604512254' : '';

  BannerAdListener get bannerAdListener => const BannerAdListener();
}
