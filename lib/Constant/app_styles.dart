import 'package:chatapp/Constant/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static InputDecoration inputFieldDecoration(
      {String? labelText, bool hasFocus = false, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: labelText,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.only(left: 15, bottom: hasFocus ? 12 : 0),
      hintStyle: const TextStyle(fontSize: 15, color: AppColors.darkGrey),
      border: InputBorder.none,
    );
  }
}
