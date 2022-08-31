part of 'navigator_cubit.dart';

class NavigatonState extends Equatable {
  NavigatonState({
    this.statelessRoute,
    required this.route,
    List<String>? routeStack,
    List<String>? pushStack,
  })  : routeStack = routeStack ?? [],
        pushStack = pushStack ?? [];

  factory NavigatonState.init() => NavigatonState(route: 'init');

  final String route;
  final String? statelessRoute;
  final List<String> routeStack;
  final List<String> pushStack;

  bool get isStateless => statelessRoute != null;

  @override
  List<Object> get props => [route, statelessRoute ?? ''];

  @override
  String toString() {
    return "RouteStack: ${routeStack.toString()} | PushStack: ${pushStack.toString()} | Route: $route | StatelessRoute: $statelessRoute |";
  }

  NavigatonState goFoward({String? route, required Function(String) callback}) {
    if (route != null) {
      if (route != this.route) {
        callback(route);
      }
      return route != this.route
          ? _copyWith(
              route: route,
              routeStack: routeStack..add(route),
              pushStack: [],
            )
          : this;
    } else {
      if (pushStack.isNotEmpty) {
        callback(pushStack.last);
      }
      return pushStack.isNotEmpty
          ? _copyWith(
              route: pushStack.last,
              routeStack: routeStack..add(pushStack.last),
              pushStack: pushStack..removeLast(),
            )
          : this;
    }
  }

  NavigatonState goBackward(VoidCallback callback) {
    if (routeStack.length > 1) {
      callback();
    }
    String currentRoute = routeStack.last;
    return routeStack.length > 1
        ? _copyWith(
            route: routeStack.elementAt(routeStack.length - 2),
            routeStack: routeStack..removeLast(),
            pushStack: pushStack..add(currentRoute),
          )
        : this;
  }

  NavigatonState _copyWith({
    String? route,
    String? statelessRoute,
    List<String>? routeStack,
    List<String>? pushStack,
  }) {
    return NavigatonState(
      route: route ?? this.route,
      statelessRoute: statelessRoute,
      routeStack: routeStack ?? this.routeStack,
      pushStack: pushStack ?? this.pushStack,
    );
  }
}
