import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/color.dart';
import '../../../logic/cubit/status_bar_cubit.dart';
import '../../../logic/services/general.dart';

class ShenStatusBar extends StatelessWidget {
  const ShenStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBarCubit, StatusBarState>(
      builder: (context, state) {
        return Container(
          height: 20,
          width: screenSize(context).width,
          color: purple,
          child: Row(
            children: [
              ...state.lItems.values,
              const Spacer(),
              ...state.rItems.values,
            ],
          ),
        );
      },
    );
  }
}
