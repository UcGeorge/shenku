import 'package:flutter/material.dart';

import '../../animations/logo.dart';
import '../logo/shen_ku_logo.dart';

class CelterLogo extends StatelessWidget {
  const CelterLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        AnimatedCircle(
          maxRadius: 140,
          minRadius: 70,
          duration: Duration(milliseconds: 1000),
        ),
        AnimatedCircle(
          maxRadius: 100,
          minRadius: 70,
          duration: Duration(milliseconds: 2000),
        ),
        ShenKuLogo(70),
      ],
    );
  }
}
