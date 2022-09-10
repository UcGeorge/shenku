import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/color.dart';
import '../../../constants/fonts.dart';
import '../../../logic/cubit/navigator_cubit.dart';
import '../../../logic/services/general.dart';
import 'app_bar/nav_buttons.dart';

class ShenAppBar extends StatefulWidget {
  const ShenAppBar({Key? key}) : super(key: key);

  @override
  State<ShenAppBar> createState() => _ShenAppBarState();
}

class _ShenAppBarState extends State<ShenAppBar> {
  bool isConnected = false;

  @override
  void initState() {
    initConnection();
    super.initState();
  }

  initConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        isConnected = true;
      });
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          if (result == ConnectivityResult.none) {
            isConnected = false;
          } else {
            isConnected = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigatonState>(
      builder: (context, state) {
        return SizedBox(
          height: appWindow.titleBarHeight,
          width: screenSize(context).width < 1200
              ? 400
              : screenSize(context).width / 3,
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: blueGrey.withOpacity(.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                NavButtons(state: state),
                const Spacer(),
                Text(
                  state.isStateless ? state.statelessRoute! : state.route,
                  style: nunito.copyWith(
                    color: white,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 44,
                  child: !isConnected
                      ? const Icon(
                          Icons.wifi_off_rounded,
                          size: 20,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
