import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:shenku/config/config.dart';
import 'package:shenku/data/sources/source.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/book.dart';
import '../../data/models/chapter.dart';
import 'storage_cubit.dart';

part 'reading_state.dart';

final _log = Logger('reader_cubit');

class ReadingCubit extends Cubit<ReadingState> {
  ReadingCubit() : super(ReadingState.init());

  late ScrollController scrollController;

  void readChapter(Book book, String chapterId, [double? offset]) {
    _log.info(
        'Reading chapter ${book.name} / ${book.chapters!.firstWhere((element) => element.id == chapterId).name}');
    emit(state.copyWith(
      book: book,
      chapterId: chapterId,
      loadedUnits: 0,
    ));
    scrollController = ScrollController(initialScrollOffset: offset ?? 0);
  }

  void stopReading(BuildContext context) {
    Navigator.pop(context);
    emit(state.copyWith(
      book: null,
      chapterId: null,
      loadedUnits: 0,
    ));
  }

  Future<void> getChapterDetails(BuildContext context) async {
    _log.info(
        'Getting chapter details for ${state.book?.name} / ${state.chapter?.name}');

    if (state.book == null || state.chapterId == null) return;

    Book book = state.book!;
    BookSource source = appBookSources.getSource(book.source);
    Chapter chapter = state.chapter!;
    final chapterIndex = book.chapters!.indexOf(chapter);

    if ((book.type == BookType.manga && chapter.chapterImages == null) ||
        (book.type == BookType.novel && chapter.chapterParagraphs == null)) {
      book.chapters![chapterIndex] =
          await source.getBookChapterDetails(chapter);
    } else {
      return;
    }

    if (chapter == state.chapter) {
      _log.info(
          'Got chapter details for ${state.book?.name} / ${state.chapter?.name}');
      emit(state.copyWith(
        book: book,
        chapterId: state.chapterId,
      ));
    }

    final bookInLibrary = context.appData.library.contains(book);
    if (bookInLibrary) {
      context.storageCubit.modifyAppData(
        context.appData.copyWith(
          library: context.appData.library
            ..remove(book)
            ..insert(0, book),
        ),
      );
    }
  }
}

extension Reader on BuildContext {
  ReadingCubit get reader => read<ReadingCubit>();
}
