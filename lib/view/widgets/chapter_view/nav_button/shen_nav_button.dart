import 'package:flutter/material.dart';

import '../../../../constants/color.dart';
import '../../../../logic/classes/alert.dart';

class ShenChapterNavButton extends StatefulWidget {
  const ShenChapterNavButton({
    Key? key,
    required this.forward,
    required this.enabled,
    required this.onTap,
  }) : super(key: key);

  final bool enabled;
  final bool forward;
  final VoidCallback onTap;

  @override
  State<ShenChapterNavButton> createState() => _ShenChapterNavButtonState();
}

class _ShenChapterNavButtonState extends State<ShenChapterNavButton> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _toogleHover,
      onExit: _toogleHover,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.enabled
            ? widget.onTap()
            : context.showWarning(
                widget.forward
                    ? 'Oops! You have reached the last chapter.'
                    : 'This is the first chapter!',
              ),
        child: Container(
          decoration: BoxDecoration(
            color: blueGrey.withOpacity(isHovering ? 1 : .15),
            borderRadius: BorderRadius.only(
              bottomLeft:
                  !widget.forward ? const Radius.circular(20) : Radius.zero,
              topLeft:
                  !widget.forward ? const Radius.circular(20) : Radius.zero,
              bottomRight:
                  widget.forward ? const Radius.circular(20) : Radius.zero,
              topRight:
                  widget.forward ? const Radius.circular(20) : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              widget.forward ? 'Next' : 'Previous',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 11,
                    color: isHovering
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    letterSpacing: 1.5,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
