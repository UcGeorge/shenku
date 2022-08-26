import 'package:flutter/material.dart';
import 'package:shenku/view/widgets/shen_scaffold/drawer.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Hero(
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
