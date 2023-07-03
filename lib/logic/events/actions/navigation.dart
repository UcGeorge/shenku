import 'package:flutter/material.dart';

import '../../cubit/navigator_cubit.dart';
import '../intents/shen_scaffold.dart';

class GoBackAction extends Action<BackIntent> {
  GoBackAction(this.context, this.navigationCubit);

  final BuildContext context;
  final NavigationCubit navigationCubit;

  @override
  Object? invoke(covariant BackIntent intent) {
    state.isStateless
        ? context.navigator.goBackwardWithoutState(context)
        : context.navigator.goBackward(context);

    return null;
  }

  @override
  bool get isActionEnabled => state.routeStack.length > 1 || state.isStateless;

  @override
  bool isEnabled(BackIntent intent) => isActionEnabled;

  NavigatonState get state => navigationCubit.state;
}

class GoFowardAction extends Action<FowardIntent> {
  GoFowardAction(this.context, this.navigationCubit);

  final BuildContext context;
  final NavigationCubit navigationCubit;

  @override
  Object? invoke(covariant FowardIntent intent) {
    context.navigator.goFoward(context);
    return null;
  }

  @override
  bool get isActionEnabled => state.pushStack.isNotEmpty && !state.isStateless;

  @override
  bool isEnabled(FowardIntent intent) => isActionEnabled;

  NavigatonState get state => navigationCubit.state;
}
