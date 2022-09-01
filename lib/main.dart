import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'constants/constants.dart';
import 'logic/cubit/book_details_cubit.dart';
import 'logic/cubit/homepage_cubit.dart';
import 'logic/cubit/navigator_cubit.dart';
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
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class ShenKu extends StatelessWidget {
  ShenKu({
    Key? key,
    required this.storageCubit,
    required this.navigatorCubit,
  })  : homepageCubit = HomepageCubit(storageCubit),
        super(key: key);

  final HomepageCubit homepageCubit;
  final String initialRoute = "init";
  final NavigationCubit navigatorCubit;
  final StorageCubit storageCubit;

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
        BlocProvider(
          create: (context) => homepageCubit,
          lazy: false,
        ),
        BlocProvider(
          create: (context) => BookDetailsCubit(),
          lazy: false,
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
