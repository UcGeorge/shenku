import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:shenku/logic/services/general.dart';
import 'package:shenku/view/widgets/shen_scaffold/window_buttons.dart';

import '../../../constants/color.dart';
import 'drawer.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: dark,
      child: Material(
        color: dark,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Column(
                    children: [
                      WindowTitleBarBox(child: MoveWindow()),
                      const Expanded(
                        child: Hero(
                          tag: 'app-drawer',
                          child: AppDrawer(),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        WindowTitleBarBox(
                          child: Row(
                            children: [
                              Expanded(child: MoveWindow()),
                              const WindowButtons()
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              color: thisWhite.withOpacity(.3),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10)),
                            ),
                            child: body,
                          ),
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
