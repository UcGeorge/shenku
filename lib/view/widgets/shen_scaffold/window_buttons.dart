import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:shenku/constants/color.dart';

final buttonColors = WindowButtonColors(
    iconNormal: white.withOpacity(.5),
    mouseOver: white.withOpacity(.1),
    mouseDown: white.withOpacity(.2),
    iconMouseOver: white,
    iconMouseDown: white.withOpacity(.5));

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: white.withOpacity(.5),
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
