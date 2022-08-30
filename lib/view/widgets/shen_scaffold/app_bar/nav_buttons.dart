import 'package:flutter/material.dart';

import '../../../../logic/cubit/navigator_cubit.dart';
import 'shen_nav_button.dart';

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
          enabled: state.routeStack.length <= 1,
          onTap: () => context.navigator.goBackward(context),
        ),
        const SizedBox(width: 4),
        ShenNavButton(
          state: state,
          quarterTurns: 2,
          enabled: state.pushStack.isEmpty,
          onTap: () => context.navigator.goFoward(context),
        )
      ],
    );
  }
}
