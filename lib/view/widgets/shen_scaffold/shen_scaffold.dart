import 'package:flutter/material.dart';
import 'package:shenku/logic/services/general.dart';

import '../../../constants/color.dart';
import 'drawer.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const Hero(
                  tag: 'app-drawer',
                  child: AppDrawer(),
                ),
                Expanded(
                  child: body,
                ),
              ],
            ),
          ),
          Container(
            height: 20,
            width: screenSize(context).width,
            color: purple,
          )
        ],
      ),
    );
  }
}
