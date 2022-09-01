import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shenku/view/widgets/status_bar/shen_status_bar.dart';

import '../../../constants/color.dart';
import '../../../logic/cubit/book_details_cubit.dart';
import '../../../logic/services/general.dart';
import '../book_details/book_details.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'window_buttons.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key, required this.body, this.startExpanded})
      : super(key: key);

  final Widget body;
  final bool? startExpanded;

  Widget _buildMainAppScene() {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
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
              Visibility(
                visible:
                    state.hasState ? screenSize(context).width >= 1360 : true,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: thisWhite.withOpacity(.3),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: state.hasState
                            ? const Radius.circular(10)
                            : Radius.zero,
                      ),
                    ),
                    child: body,
                  ),
                ),
              ),
              if (state.hasState && screenSize(context).width < 1360)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: thisWhite.withOpacity(.15),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: BookDetailsView(),
                  ),
                ),
              AnimatedContainer(
                width: (state.hasState && !(screenSize(context).width < 1360))
                    ? 600
                    : 0,
                padding: const EdgeInsets.all(24),
                margin: state.hasState
                    ? const EdgeInsets.only(left: 10)
                    : EdgeInsets.zero,
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  color: thisWhite.withOpacity(.15),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: state.hasState
                    ? BookDetailsView()
                    : const SizedBox.expand(),
              ),
            ],
          ),
        );
      },
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
            const ShenStatusBar(),
          ],
        ),
      ),
    );
  }
}
