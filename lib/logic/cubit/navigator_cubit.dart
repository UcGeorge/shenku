import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../view/pages/alertView.dart';
import '../../view/pages/entry.dart';
import '../../view/pages/shen_scaffold.dart';
import '../classes/alert.dart';

part 'navigator_state.dart';

final _log = Logger('navigation_cubit');

class NavigationCubit extends Cubit<NavigatonState> {
  NavigationCubit() : super(NavigatonState.init());

  void showAlert(BuildContext context, Alert alert) {
    Navigator.of(context).pushNamed('alert', arguments: alert);
  }

  void showActionSheet(BuildContext context, {required Widget actionSheet}) {
    Navigator.of(context).pushNamed('action', arguments: actionSheet);
  }

  void goToShenScaffold(BuildContext context) {
    Navigator.of(context)
        .pushNamed('scaffold', arguments: const ShenScaffold());
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var path = settings.name;

    switch (path) {
      case 'init':
        return _initRoute();
      case 'alert':
        return _alertRoute(settings.arguments as Alert);
      case 'action':
        return _actionSheetRoute(settings.arguments as Widget);
      case 'scaffold':
        return _shenScaffoldRoute(settings.arguments as ShenScaffold);
      default:
        return _initRoute();
    }
  }

  static Route _initRoute() {
    return CupertinoPageRoute(
      builder: (context) => const EntryPoint(),
    );
  }

  static Route _alertRoute(Alert alert) {
    return PageRouteBuilder(
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      fullscreenDialog: false,
      opaque: false,
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          AlertView(alert: alert),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route _actionSheetRoute(Widget child) {
    return PageRouteBuilder(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(.2),
      fullscreenDialog: false,
      opaque: false,
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route _shenScaffoldRoute(ShenScaffold scaffold) {
    return PageRouteBuilder(
      barrierColor: Colors.black.withOpacity(.5),
      opaque: false,
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          scaffold,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        Animatable<double> tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

extension Navigation on BuildContext {
  NavigationCubit get navigator => read<NavigationCubit>();
}
