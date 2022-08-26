import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../logic/classes/alert.dart';
import '../../logic/cubit/navigator_cubit.dart';
import '../../logic/cubit/storage_cubit.dart';
import '../../logic/services/general.dart';
import '../widgets/init_page/logo.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) =>
        context.storageCubit.initializeDirectory(onComplete: onInitComplete));
  }

  void onInitComplete(bool success, String? error) {
    if (success) {
      context.navigator.goToHome(context);
    } else {
      context.showError(error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onDoubleTap: () {
                context.testAlert();
                debugPrint("Tap Event");
              },
              child: const CelterLogo(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText('Shen-Ku'),
                    FlickerAnimatedText('Loading...'),
                  ],
                  onTap: doNothing,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
