import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../logic/cubit/navigator_cubit.dart';
import '../../../../logic/events/intents/shen_scaffold.dart';
import 'shen_nav_button.dart';

final _log = Logger('nav_buttons');

class NavButtons extends StatelessWidget {
  const NavButtons({
    Key? key,
    required this.state,
  }) : super(key: key);

  final NavigatonState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShenNavButton(
          state: state,
          enabled: state.routeStack.length > 1 || state.isStateless,
          onTap: () =>
              Actions.maybeInvoke<BackIntent>(context, const BackIntent()),
        ),
        const SizedBox(width: 4),
        ShenNavButton(
          state: state,
          quarterTurns: 2,
          enabled: state.pushStack.isNotEmpty && !state.isStateless,
          onTap: () =>
              Actions.maybeInvoke<FowardIntent>(context, const FowardIntent()),
        )
      ],
    );
  }
}
