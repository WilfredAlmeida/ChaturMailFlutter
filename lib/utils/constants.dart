import 'package:flutter/material.dart';

// const API_URL = String.fromEnvironment("STAGE_URL");
const API_URL = String.fromEnvironment("LOCALHOST_URL");
// const API_URL = "https://email-generator-api-prod.herokuapp.com";
// const API_URL = String.fromEnvironment("PROD_URL");
// const API_URL = "http://192.168.33.54:4545";
// const API_URL = "http://192.168.0.208:4545";
//--dart-define=PROD_URL=https://email-generator-api-prod.herokuapp.com --dart-define=LOCALHOST_URL=http://192.168.0.208:4545 --dart-define=STAGE_URL=https://email-generator-api.herokuapp.com
// Success
const SUCCESS = 200;

// Errors
const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
const API_NOT_REACHABLE = 104;

const INVALID_BODY = 400;

const mainColor = Color.fromRGBO(37, 64, 71, 1);
const greenMainColor2 = Color.fromRGBO(37, 232, 138, 1);
const greenMainColor = Color.fromRGBO(213, 255, 218, 1);

//Needed to call api in dashboard
var didItOnce = false;

//Needed for bottom nav bar selected item
// var currentIndex = 0;
