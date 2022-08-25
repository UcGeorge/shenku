import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/constants.dart';
import 'logic/cubit/storage_cubit.dart';
import 'view/pages/entry.dart';

void main() {
  runApp(ShenKu(
    storageCubit: StorageCubit(),
  ));

  doWhenWindowReady(() {
    var initialSize = const Size(700, 516);
    appWindow.minSize = initialSize;
    appWindow.title = 'ShenKu';
  });
}

class ShenKu extends StatelessWidget {
  const ShenKu({Key? key, required this.storageCubit}) : super(key: key);

  final StorageCubit storageCubit;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShenKu',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: kDarkThemeData,
      home: BlocProvider(
        create: (context) => storageCubit,
        child: const EntryPoint(),
      ),
    );
  }
}
