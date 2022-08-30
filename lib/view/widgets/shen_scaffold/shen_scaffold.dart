import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../logic/services/general.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'window_buttons.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key, required this.body, this.startExpanded})
      : super(key: key);

  final Widget body;
  final bool? startExpanded;

  Container _buildBottomBar(BuildContext context) {
    return Container(
      height: 20,
      width: screenSize(context).width,
      color: purple,
    );
  }

  Expanded _buildMainAppScene() {
    return Expanded(
      child: Row(
        children: [
          Column(
            children: [
              WindowTitleBarBox(child: MoveWindow()),
              Expanded(
                child: Hero(
                  tag: 'app-drawer',
                  child: AppDrawer(
                    startExpanded: startExpanded,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: thisWhite.withOpacity(.3),
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(10)),
              ),
              child: body,
            ),
          ),
        ],
      ),
    );
  }

  WindowTitleBarBox _buildAppTitleBar() {
    return WindowTitleBarBox(
      child: Row(
        children: [
          SizedBox(width: 90, child: MoveWindow()),
          Expanded(child: MoveWindow()),
          const ShenAppBar(),
          Expanded(child: MoveWindow()),
          const WindowButtons()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: dark,
      child: Material(
        color: dark,
        child: Column(
          children: [
            _buildAppTitleBar(),
            _buildMainAppScene(),
            _buildBottomBar(context)
          ],
        ),
      ),
    );
  }
}
