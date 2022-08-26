import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:shenku/logic/cubit/navigator_cubit.dart';

import 'constants/constants.dart';
import 'logic/cubit/storage_cubit.dart';

void main() {
  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name} : ${record.time} : '
        '${record.loggerName} : '
        '${record.message}');
  });

  runApp(ShenKu(
    storageCubit: StorageCubit(),
    navigatorCubit: NavigationCubit(),
  ));

  doWhenWindowReady(() {
    var initialSize = const Size(700, 516);
    appWindow.minSize = initialSize;
    appWindow.title = 'ShenKu';
  });
}

class ShenKu extends StatelessWidget {
  const ShenKu(
      {Key? key, required this.storageCubit, required this.navigatorCubit})
      : super(key: key);

  final String initialRoute = "init";
  final StorageCubit storageCubit;
  final NavigationCubit navigatorCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => storageCubit,
          lazy: false,
        ),
        BlocProvider(
          create: (context) => navigatorCubit,
        ),
      ],
      child: MaterialApp(
        title: 'ShenKu',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: kDarkThemeData,
        onGenerateRoute: NavigationCubit.onGenerateRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
