import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import 'drawer.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark,
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
    );
  }
}
