import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../constants/color.dart';
import '../../../constants/fonts.dart';
import '../../../data/models/shen_image.dart';

final _log = Logger('multi_source_image');

class MultiSourceImage extends StatefulWidget {
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
    this.shouldRetry = false,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Widget? errorPlaceholder;
  final BoxFit? fit;
  final Widget? loadingIndicator;
  final VoidCallback? onLoadComplete;
  final double radius;
  final String? referer;
  final bool shouldRetry;
  final ImageSource source;
  final String url;
  final bool useOriginalSize;

  @override
  State<MultiSourceImage> createState() => _MultiSourceImageState();
}

class _MultiSourceImageState extends State<MultiSourceImage> {
  Widget errorBuilder(BuildContext _, Object obj, StackTrace? stackTrace) {
    _log.warning('$obj', obj, stackTrace);
    // _log.warning('$obj\n$stackTrace', obj, stackTrace);
    return widget.shouldRetry
        ? SizedBox(
            height: 200,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: widget.backgroundColor ??
                      (blueGrey).withOpacity(
                          widget.errorPlaceholder == null ? .67 : .3),
                  radius: widget.radius,
                  child: widget.errorPlaceholder ??
                      Icon(
                        Icons.error_outline_rounded,
                        color: widget.accent ?? violet,
                        size: widget.radius,
                      ),
                ),
                Text(
                  'The image could not be loaded',
                  overflow: TextOverflow.ellipsis,
                  style: nunito.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  style: ElevatedButton.styleFrom(
                    primary: violet,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    overflow: TextOverflow.ellipsis,
                    style: nunito.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
          )
        : Center(
            child: CircleAvatar(
              backgroundColor: widget.backgroundColor ??
                  (blueGrey)
                      .withOpacity(widget.errorPlaceholder == null ? .67 : .3),
              radius: widget.radius,
              child: widget.errorPlaceholder ??
                  Icon(
                    Icons.error_outline_rounded,
                    color: widget.accent ?? violet,
                    size: widget.radius,
                  ),
            ),
          );
  }

  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.loadingIndicator ??
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: widget.backgroundColor ??
                      (blueGrey).withOpacity(
                          widget.errorPlaceholder == null ? .67 : .3),
                  radius: widget.radius,
                  child: CircularProgressIndicator(
                    color: widget.accent ?? violet,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  style: ElevatedButton.styleFrom(
                    primary: violet,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Reload',
                    overflow: TextOverflow.ellipsis,
                    style: nunito.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget frameBuilder(context, widget, progress, bol) {
    if (progress != null) {
      return widget;
    }
    return widget.loadingIndicator ??
        Center(
          child: CircleAvatar(
            backgroundColor: widget.backgroundColor ??
                (blueGrey)
                    .withOpacity(widget.errorPlaceholder == null ? .67 : .3),
            radius: widget.radius,
            child: CircularProgressIndicator(
              color: widget.accent ?? violet,
              value: (progress == null || progress == 100)
                  ? null
                  : (progress / 100),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) => widget.source == ImageSource.file
      ? Image.file(
          File(widget.url),
          height: widget.useOriginalSize ? null : widget.radius * 2,
          width: widget.useOriginalSize ? null : widget.radius * 2,
          fit: widget.fit ?? BoxFit.contain,
          alignment: Alignment.center,
          errorBuilder: errorBuilder,
          frameBuilder: frameBuilder,
        )
      : Image.network(
          widget.url,
          fit: widget.fit ?? BoxFit.contain,
          height: widget.useOriginalSize ? null : widget.radius * 2,
          width: widget.useOriginalSize ? null : widget.radius * 2,
          headers: {
            if (widget.referer != null) 'referer': widget.referer!,
          },
          errorBuilder: errorBuilder,
          loadingBuilder: loadingBuilder,
        )
    ..image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          widget.onLoadComplete?.call();
        },
      ),
    );
}
