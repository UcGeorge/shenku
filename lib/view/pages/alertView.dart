import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../logic/classes/alert.dart';
import '../../logic/services/general.dart';

class AlertView extends StatefulWidget {
  const AlertView({Key? key, required this.alert}) : super(key: key);

  final Alert alert;

  @override
  State<AlertView> createState() => _AlertViewState();
}

class _AlertViewState extends State<AlertView> {
  bool shouldPop = true;

  void pop() {
    if (shouldPop && mounted) {
      Navigator.of(context).pop();
      shouldPop = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      widget.alert.duration ?? Alert.kDialogueDuration,
      pop,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            width: screenSize(context).width < 1200
                ? 400
                : screenSize(context).width / 3,
            height: screenViewPadding(context).top + Alert.kBarHeight,
            margin: const EdgeInsets.all(24),
            padding: EdgeInsets.only(
              left: 18,
              right: 22,
              top: screenViewPadding(context).top,
            ),
            decoration: BoxDecoration(
              color: widget.alert.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(widget.alert.iconUrl),
                const SizedBox(width: 18),
                Expanded(
                  child: Text(
                    widget.alert.text,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Alert.kTextStyle,
                  ),
                ),
                IconButton(
                  onPressed: pop,
                  icon: Icon(
                    Icons.close,
                    color: Alert.kCloseIconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
