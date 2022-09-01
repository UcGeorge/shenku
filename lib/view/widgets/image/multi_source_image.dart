import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shenku/constants/color.dart';
import 'package:shenku/data/models/shen_image.dart';

class MultiSourceImage extends StatelessWidget {
  const MultiSourceImage({
    Key? key,
    required this.source,
    required this.url,
    this.accent,
    this.backgroundColor,
    this.errorPlaceholder,
    this.loadingIndicator,
    required this.radius,
    this.fit,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Widget? errorPlaceholder;
  final Widget? loadingIndicator;
  final double radius;
  final ImageSource source;
  final String url;
  final BoxFit? fit;

  Widget errorBuilder(BuildContext _, Object obj, StackTrace? stackTrace) {
    // _log.warning('$obj\n$stackTrace', obj, stackTrace);
    return Center(
      child: CircleAvatar(
        backgroundColor: backgroundColor ??
            (blueGrey).withOpacity(errorPlaceholder == null ? .67 : .3),
        radius: radius,
        child: errorPlaceholder ??
            Icon(
              Icons.error_outline_rounded,
              color: accent ?? violet,
              size: radius,
            ),
      ),
    );
  }

  Widget frameBuilder(context, widget, progress, bol) {
    if (progress != null) {
      return widget;
    }
    return loadingIndicator ??
        Center(
          child: CircleAvatar(
            backgroundColor: backgroundColor ??
                (blueGrey).withOpacity(errorPlaceholder == null ? .67 : .3),
            radius: radius,
            child: CircularProgressIndicator(
              color: accent ?? violet,
              value: (progress == null || progress == 100)
                  ? null
                  : (progress / 100),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) => source == ImageSource.file
      ? Image.file(
          File(url),
          height: radius * 2,
          width: radius * 2,
          fit: fit ?? BoxFit.contain,
          alignment: Alignment.center,
          errorBuilder: errorBuilder,
          frameBuilder: frameBuilder,
        )
      : Image(
          fit: fit ?? BoxFit.contain,
          height: radius * 2,
          width: radius * 2,
          image: NetworkImage(url),
          errorBuilder: errorBuilder,
          frameBuilder: frameBuilder,
        );
}
