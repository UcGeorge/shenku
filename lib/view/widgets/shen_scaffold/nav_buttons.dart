import 'package:flutter/material.dart';

import '../../../logic/cubit/navigator_cubit.dart';

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
        GestureDetector(
          onTap: state.routeStack.length <= 1
              ? () {}
              : () {
                  context.navigator.goBackward(context);
                },
          child: Icon(
            Icons.keyboard_backspace_rounded,
            size: 18,
            color: state.routeStack.length <= 1
                ? Theme.of(context).iconTheme.color!.withOpacity(0.3)
                : Theme.of(context).iconTheme.color,
          ),
        ),
        const SizedBox(width: 8),
        RotatedBox(
          quarterTurns: 2,
          child: GestureDetector(
            onTap: state.pushStack.isEmpty
                ? () {}
                : () {
                    context.navigator.goFoward(context);
                  },
            child: Icon(
              Icons.keyboard_backspace_rounded,
              size: 18,
              color: state.pushStack.isEmpty
                  ? Theme.of(context).iconTheme.color!.withOpacity(0.3)
                  : Theme.of(context).iconTheme.color,
            ),
          ),
        )
      ],
    );
  }
}
