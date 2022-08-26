import 'package:flutter/material.dart';
import 'package:shenku/view/widgets/shen_scaffold/drawer.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          AppDrawer(),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
