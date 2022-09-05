import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../constants/color.dart';
import '../../../data/models/shen_image.dart';

final _log = Logger('navigation_cubit');

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
    this.referer,
    this.useOriginalSize = false,
    this.onLoadComplete,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Widget? errorPlaceholder;
  final BoxFit? fit;
  final Widget? loadingIndicator;
  final double radius;
  final String? referer;
  final ImageSource source;
  final String url;
  final bool useOriginalSize;
  final VoidCallback? onLoadComplete;

  Widget errorBuilder(BuildContext _, Object obj, StackTrace? stackTrace) {
    _log.warning('$obj\n$stackTrace', obj, stackTrace);
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

  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return loadingIndicator ??
        Center(
          child: CircleAvatar(
            backgroundColor: backgroundColor ??
                (blueGrey).withOpacity(errorPlaceholder == null ? .67 : .3),
            radius: radius,
            child: CircularProgressIndicator(
              color: accent ?? violet,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
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
          height: useOriginalSize ? null : radius * 2,
          width: useOriginalSize ? null : radius * 2,
          fit: fit ?? BoxFit.contain,
          alignment: Alignment.center,
          errorBuilder: errorBuilder,
          frameBuilder: frameBuilder,
        )
      : Image.network(
          url,
          fit: fit ?? BoxFit.contain,
          height: useOriginalSize ? null : radius * 2,
          width: useOriginalSize ? null : radius * 2,
          headers: {
            if (referer != null) 'referer': referer!,
          },
          errorBuilder: errorBuilder,
          loadingBuilder: loadingBuilder,
        )
    ..image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          onLoadComplete?.call();
        },
      ),
    );
}
