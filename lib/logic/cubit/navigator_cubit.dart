import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../view/pages/alertView.dart';
import '../../view/pages/entry.dart';
import '../../view/pages/explore.dart';
import '../../view/pages/home.dart';
import '../../view/pages/library.dart';
import '../classes/alert.dart';

part 'navigator_state.dart';

final _log = Logger('navigation_cubit');

class NavigationCubit extends Cubit<NavigatonState> {
  NavigationCubit() : super(NavigatonState.init());

  @override
  void emit(NavigatonState state) {
    _log.info(state);
    super.emit(state);
  }

  void clearStateless(BuildContext context) {
    if (state.isStateless) {
      _log.warning('Clearing stateless');
      Navigator.pop(context);
      emit(state._copyWith(statelessRoute: null));
    }
  }

  void showAlert(BuildContext context, Alert alert) {
    Navigator.of(context).pushNamed('alert', arguments: alert);
  }

  void showActionSheet(BuildContext context, {required Widget actionSheet}) {
    Navigator.of(context).pushNamed('action', arguments: actionSheet);
  }

  void goToHome(BuildContext context, [bool startExpanded = false]) {
    clearStateless(context);
    emit(
      state.goFoward(
        route: 'Home',
        callback: (_) => Navigator.of(context).pushNamed(
          'scaffold',
          arguments: HomePage(startExpanded: startExpanded),
        ),
      ),
    );
  }

  void goToExplore(BuildContext context, [bool startExpanded = false]) {
    clearStateless(context);
    emit(
      state.goFoward(
        route: 'Explore',
        callback: (_) => Navigator.of(context).pushNamed(
          'scaffold',
          arguments: ExplorePage(startExpanded: startExpanded),
        ),
      ),
    );
  }

  void goToLibrary(BuildContext context, [bool startExpanded = false]) {
    clearStateless(context);
    emit(
      state.goFoward(
        route: 'Library',
        callback: (_) => Navigator.of(context).pushNamed(
          'scaffold',
          arguments: LibraryPage(startExpanded: startExpanded),
        ),
      ),
    );
  }

  void goFoward(BuildContext context) {
    clearStateless(context);
    emit(state.goFoward(
      callback: (route) {
        switch (route) {
          case 'Home':
            Navigator.of(context).pushNamed(
              'scaffold',
              arguments: const HomePage(),
            );
            break;
          case 'Explore':
            Navigator.of(context).pushNamed(
              'scaffold',
              arguments: const ExplorePage(),
            );
            break;
          case 'Library':
            Navigator.of(context).pushNamed(
              'scaffold',
              arguments: const LibraryPage(),
            );
        }
      },
    ));
  }

  void goBackward(BuildContext context) {
    clearStateless(context);
    emit(state.goBackward(() => Navigator.pop(context)));
  }

  void goForwardWithoutState(BuildContext context, Widget child, String route) {
    Navigator.of(context).pushNamed(
      'scaffold',
      arguments: child,
    );

    emit(state._copyWith(statelessRoute: route));
  }

  void goBackwardWithoutState(BuildContext context) {
    Navigator.pop(context);
    emit(state._copyWith(statelessRoute: null));
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
        return _shenScaffoldRoute(settings.arguments as Widget);
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

  static Route _shenScaffoldRoute(Widget scaffold) {
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
