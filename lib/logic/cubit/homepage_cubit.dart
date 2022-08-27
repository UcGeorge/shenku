import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:shenku/config/config.dart';
import 'package:shenku/data/models/book.dart';
import 'package:shenku/logic/cubit/storage_cubit.dart';
import 'package:uuid/uuid.dart';

part 'homepage_state.dart';

final _log = Logger('homepage_cubit');

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit(this.storageCubit) : super(HomepageState.init()) {
    storageCubitStreamSubscription =
        storageCubit.stream.listen(updateStateFromStorage);
  }

  @override
  void emit(HomepageState state) {
    _log.info(state);
    super.emit(state);
  }

  final StorageCubit storageCubit;
  late StreamSubscription storageCubitStreamSubscription;

  void updateStateFromStorage(StorageState storageState) {
    emit(state.copyWith(library: storageState.appData.library));
  }

  void getHomepageFromSources() {
    for (var element in appBookSources) {
      if (state.sourcesHomepage[element.name]?.isEmpty ?? true) {
        var key = element.name;

        _log.info('Getting $key homepage');

        var temp = state.sourcesHomepage;
        temp[key] = null;
        emit(state.copyWith(sourcesHomepage: temp));

        element.getHomePage().then(
          (value) {
            var key = element.name;
            var temp = state.sourcesHomepage;
            temp[key] = value;
            emit(state.copyWith(sourcesHomepage: temp));
          },
        );
      }
    }
  }

  @override
  Future<void> close() {
    storageCubitStreamSubscription.cancel();
    return super.close();
  }
}
