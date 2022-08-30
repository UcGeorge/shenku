import 'package:flutter/material.dart';

import '../../../../constants/color.dart';
import '../../../../logic/cubit/navigator_cubit.dart';
import '../../../../logic/services/general.dart';

class ShenNavButton extends StatefulWidget {
  const ShenNavButton({
    Key? key,
    required this.state,
    this.quarterTurns,
    required this.onTap,
    required this.enabled,
  }) : super(key: key);

  final bool enabled;
  final VoidCallback onTap;
  final int? quarterTurns;
  final NavigatonState state;

  @override
  State<ShenNavButton> createState() => _ShenNavButtonState();
}

class _ShenNavButtonState extends State<ShenNavButton> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _toogleHover,
      onExit: _toogleHover,
      child: RotatedBox(
        quarterTurns: widget.quarterTurns ?? 0,
        child: GestureDetector(
          onTap: widget.enabled ? doNothing : widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(1),
            margin: const EdgeInsets.symmetric(vertical: .5),
            decoration: BoxDecoration(
              color:
                  isHovering && !widget.enabled ? white.withOpacity(.15) : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              size: 16,
              color: widget.enabled
                  ? Theme.of(context).iconTheme.color!.withOpacity(0.3)
                  : Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
