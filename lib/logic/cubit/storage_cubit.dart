import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shenku/data/models/history_item.dart';
import 'package:uuid/uuid.dart';

import '../../config/config.dart';
import '../../data/models/app_data.dart';
import '../../data/models/book.dart';

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
    Directory appDocDir = await getApplicationDocumentsDirectory();

    final directory = Directory(appDir(appDocDir.path));
    try {
      //* Create App directory if it does not exist
      if (!await directory.exists()) {
        _log.info('Creating app directory');
        await directory.create(recursive: true);
      }

      final dataFile = File(dataFileDir(appDocDir.path));
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
    }
  }

  Future<void> modifyAppData(AppData appData) async {
    emit(state.copyWith(appData: appData));
    await saveData();
  }

  Future<void> addToLibrary(Book book) async {
    _log.info('Adding to library: ${book.name}');
    emit(state.copyWith(
      appData: state.appData.copyWith(
        library: state.appData.library..add(book),
      ),
    ));
    await saveData();
  }

  Future<void> removeFromLibrary(Book book) async {
    _log.info('Removing from library: ${book.name}');
    emit(state.copyWith(
      appData: state.appData.copyWith(
        library: state.appData.library..remove(book),
      ),
    ));
    await saveData();
  }

  Future<void> addToHistory({
    required bookId,
    required chapterId,
    required int pageNumber,
    required double position,
  }) async {
    _log.info('Adding to history: $bookId - $chapterId');
    final chapterHistoryItem = ChapterHistoryItem(
      chapterId: chapterId,
      position: position,
      pageNumber: pageNumber,
    );
    emit(state.copyWith(
      appData: state.appData.copyWith(
        history: (state.appData.history)
          ..update(
            bookId,
            (value) => value.copyWith(
              lastReadChapterId: chapterId,
              chapterHistory: state.appData.history[bookId]!.chapterHistory
                ..update(
                  chapterId,
                  (value) => chapterHistoryItem,
                  ifAbsent: () => chapterHistoryItem,
                ),
            ),
            ifAbsent: () => BookHistoryItem(
              bookId: bookId,
              lastReadChapterId: chapterId,
              chapterHistory: {chapterId: chapterHistoryItem},
            ),
          ),
      ),
    ));
    await saveData();
  }

  Future<void> removeFromHistory({
    required bookId,
    required chapterId,
    String? addChapterId,
  }) async {
    if (!state.appData.history.containsKey(bookId)) return;
    if (!state.appData.history[bookId]!.chapterHistory.containsKey(chapterId)) {
      return;
    }

    _log.info('Removing from history: $bookId - $chapterId');
    emit(state.copyWith(
      appData: state.appData.copyWith(
        history: (state.appData.history)
          ..update(
            bookId,
            (value) => value.copyWith(
              lastReadChapterId: chapterId,
              chapterHistory: state.appData.history[bookId]!.chapterHistory
                ..remove(chapterId),
            ),
          ),
      ),
    ));

    if (state.appData.history[bookId]!.chapterHistory.isEmpty) {
      emit(state.copyWith(
        appData: state.appData.copyWith(
          history: (state.appData.history)..remove(bookId),
        ),
      ));
    }
    if (addChapterId != null) {
      await addToHistory(
        bookId: bookId,
        chapterId: addChapterId,
        pageNumber: 1,
        position: 0,
      );
    } else {
      await saveData();
    }
  }

  Future<void> saveData() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _log.info('Writing to app data file');
    final dataFile = File(dataFileDir(appDocDir.path));
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
