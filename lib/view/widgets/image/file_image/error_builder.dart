import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../constants/color.dart';
import '../../../../constants/fonts.dart';
import '../../../../data/models/shen_image.dart';

final _log = Logger('multi_source_image_error');

class FileImageErrorBuilder extends StatelessWidget {
  const FileImageErrorBuilder({
    Key? key,
    this.accent,
    this.backgroundColor,
    this.errorPlaceholder,
    required this.radius,
    required this.shouldRetry,
    required this.source,
    required this.errorObj,
    this.stackTrace,
    this.onRetry,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Object errorObj;
  final Widget? errorPlaceholder;
  final VoidCallback? onRetry;
  final double radius;
  final bool shouldRetry;
  final ImageSource source;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    _log.warning('$errorObj', errorObj, stackTrace);
    // _log.warning('$obj\n$stackTrace', obj, stackTrace);
    return shouldRetry
        ? SizedBox(
            height: 200,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: backgroundColor ??
                      (blueGrey)
                          .withOpacity(errorPlaceholder == null ? .67 : .3),
                  radius: radius,
                  child: errorPlaceholder ??
                      Icon(
                        Icons.error_outline_rounded,
                        color: accent ?? violet,
                        size: radius,
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
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: violet,
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
}
