part of 'navigator_cubit.dart';

class NavigatonState extends Equatable {
  NavigatonState({required this.route, List<String>? routeStack})
      : routeStack = routeStack ?? [];

  factory NavigatonState.init() => NavigatonState(route: 'init');

  final String route;
  final List<String> routeStack;

  @override
  List<Object> get props => [route];

  @override
  String toString() {
    return "RouteStack: ${routeStack.toString()}";
  }

  NavigatonState pushRoute(String route, VoidCallback callback) {
    if (route != this.route) {
      callback();
    }
    return route != this.route
        ? _copyWith(
            route: route,
            routeStack: routeStack..add(route),
          )
        : this;
  }

  NavigatonState popRoute(VoidCallback callback) {
    if (routeStack.length > 1) {
      callback();
    }
    return routeStack.length > 1
        ? _copyWith(
            route: routeStack.elementAt(routeStack.length - 2),
            routeStack: routeStack..removeLast(),
          )
        : this;
  }

  NavigatonState _copyWith({
    String? route,
    List<String>? routeStack,
  }) {
    return NavigatonState(
      route: route ?? this.route,
      routeStack: routeStack ?? this.routeStack,
    );
  }
}
