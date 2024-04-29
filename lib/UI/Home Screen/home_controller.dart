import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isDarkMode = false.obs;

  toggleTheme(value) {
    if (isDarkMode == false) {
      Get.changeTheme(ThemeData.light());
      isDarkMode.value = true;
    } else {
      Get.changeTheme(ThemeData.dark());
      isDarkMode.value = false;
    }
  }
}
