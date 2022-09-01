import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'status_bar_state.dart';

class StatusBarCubit extends Cubit<StatusBarState> {
  StatusBarCubit() : super(StatusBarState.init());

  void addrItem(String key, Widget value) => emit(state.copyWith(
        rItems: state.rItems..putIfAbsent(key, () => value),
      ));

  void removerItem(String key) => emit(state.copyWith(
        rItems: state.rItems..remove(key),
      ));

  void addlItem(String key, Widget value) => emit(state.copyWith(
        lItems: state.lItems..putIfAbsent(key, () => value),
      ));

  void removelItem(String key) => emit(state.copyWith(
        lItems: state.lItems..remove(key),
      ));

  void update(String key, Widget value) {
    emit(state.copyWith(
      lItems: state.lItems.containsKey(key)
          ? (state.lItems..update(key, (_) => value))
          : null,
      rItems: state.rItems.containsKey(key)
          ? (state.rItems..update(key, (_) => value))
          : null,
    ));
  }

  void clear() => emit(state.copyWith(
        lItems: state.lItems..clear(),
        rItems: state.rItems..clear(),
      ));
}

extension StatusBar on BuildContext {
  StatusBarCubit get statusBar => read<StatusBarCubit>();
}
