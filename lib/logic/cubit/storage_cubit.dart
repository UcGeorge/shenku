import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import '../../config/config.dart';
import '../../data/models/app_data.dart';

part 'storage_state.dart';

final _log = Logger('storage_cubit');

class StorageCubit extends Cubit<StorageState> {
  StorageCubit() : super(StorageState.init());

  @override
  void emit(StorageState state) {
    _log.info(state);
    super.emit(state);
  }

  void initializeDirectory(
      {required void Function(bool, String?) onComplete}) async {
    _log.info('Initializing storage');
    final directory = File(appDir);
    try {
      //* Create App directory if it does not exist
      if (!await directory.exists()) {
        _log.info('Creating app directory');
        await directory.create(recursive: true);
      }

      final dataFile = File(dataFileDir);
      if (!await dataFile.exists()) {
        _log.info('Creating app data file');
        await dataFile.create(recursive: true);
        await dataFile.writeAsString(
          state.appData.toJson(),
          mode: FileMode.write,
        );
      } else {
        _log.info('Reading from app data file');
        String contents = await dataFile.readAsString();
        final stateData = AppData.fromJson(contents);
        emit(state.copyWith(appData: stateData));
      }
      onComplete(true, null);
    } on Exception catch (ex) {
      _log.severe(ex);
      onComplete(false, ex.toString());
      debugPrint('initializeDirectory exception: $ex');
    }
  }

  void saveData() async {
    _log.info('Writing to app data file');
    final dataFile = File(dataFileDir);
    await dataFile.writeAsString(
      state.appData.toJson(),
      mode: FileMode.write,
    );
  }
}

extension AppStorage on BuildContext {
  StorageCubit get storageCubit => read<StorageCubit>();
  AppData get appData => read<StorageCubit>().state.appData;
}
