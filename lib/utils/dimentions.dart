import 'package:get/get.dart';

class Dimentions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // 4.23 es height scalling factor 932/220 (SizePantalla/SizeContainerIPhone14)
  static double pageViewContainer =
      screenHeight / 4.23; // obtener height de containers Stack
  static double pageViewMainContainer =
      screenHeight / 2.9125; // obtener height de container principal
  static double pageViewTextContainer =
      screenHeight / 7.76; // obtener height de container de texto

  // 932/10 = 93.2
  static double height10 = screenHeight / 93.2;
  static double height15 = screenHeight / 62.13;

  static double width10 = screenHeight / 93.2;
  static double width15 = screenHeight / 62.13;
  static double width20 = screenHeight / 46.6;

  // specific
  static double font20 = screenHeight / 46.6;
  static double radius20 = screenHeight / 46.6;
  static double radius30 = screenHeight / 31.6;
  static double icon24 = screenHeight / 38.83;
  static double img120 = screenHeight / 7.766;
  static double img350 = screenHeight / 2.66;

  // General
  static double pixels4 = screenHeight / 233;
  static double pixels5 = screenHeight / 186.4;
  static double pixels10 = screenHeight / 93.2;
  static double pixels15 = screenHeight / 62.13;
  static double pixels18 = screenHeight / 51.77;
  static double pixels20 = screenHeight / 46.6;
  static double pixels25 = screenHeight / 37.28;
  static double pixels30 = screenHeight / 31.06;
  static double pixels35 = screenHeight / 26.628;
  static double pixels40 = screenHeight / 23.3;
  static double pixels45 = screenHeight / 20.71;
  static double pixels50 = screenHeight / 18.64;
  static double pixels60 = screenHeight / 15.53;
  static double pixels70 = screenHeight / 13.31;
  static double pixels140 = screenHeight / 6.657;
  static double pixels200 = screenHeight / 4.66;
  static double pixels250 = screenHeight / 3.728;
  static double pixels300 = screenHeight / 3.106;
}
