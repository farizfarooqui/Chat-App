import 'dart:ui';

import 'package:flutter/material.dart';

class ForegroundWidget extends StatelessWidget {
  final List<Widget>? children;

  const ForegroundWidget({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.purple[300],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue[300],
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        if (children != null) ...children!,
      ],
    );
  }
}
