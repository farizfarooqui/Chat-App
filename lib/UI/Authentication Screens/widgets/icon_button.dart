import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final Color borderColor;
  final double height;
  final double? width;
  final VoidCallback? onPressed;
  const CustomIconButton(
      {super.key,
      required this.imagePath,
      required this.backgroundColor,
      required this.borderColor,
      required this.height,
      this.width,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll(30),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 2, color: borderColor),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(
              width ?? double.infinity, height)), // Butto  height and width
        ),
        child: Image.asset(
          imagePath,
          height: (height - 26),
        ));
  }
}
