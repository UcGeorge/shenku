import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/color.dart';
import '../../../constants/svg.dart';
import '../../../logic/services/logo_scaling.dart';

class ShenKuLogo extends StatelessWidget {
  const ShenKuLogo(
    this.height, {
    Key? key,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: height,
      backgroundColor: purple,
      child: CircleAvatar(
        radius: innerRadius(height),
        backgroundColor: thisWhite,
        child: SvgPicture.asset(
          logoTextSvg,
          color: dark,
          height: logoHeight(height),
        ),
      ),
    );
  }
}
