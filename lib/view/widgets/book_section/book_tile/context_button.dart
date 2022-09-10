import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/icons.dart';
import '../../../../data/models/book.dart';
import '../../../../logic/cubit/navigator_cubit.dart';
import '../../../../logic/cubit/reading_cubit.dart';
import '../../../../logic/cubit/storage_cubit.dart';
import '../../../../logic/services/library.dart';
import '../../../pages/chapter.dart';
import 'rv_context_button.dart';

class BookTileContextButton extends StatelessWidget {
  const BookTileContextButton(this.book, this.context, {Key? key})
      : super(key: key);

  final Book book;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    final storage = context.watch<StorageCubit>();
    bool isInLibrary = storage.state.appData.library.contains(book);
    bool hasChapters = book.chapters?.isNotEmpty ?? false;
    bool isInHistory =
        hasChapters && storage.state.appData.history.containsKey(book.id);

    return isInLibrary
        ? hasChapters
            ? isInHistory
                ? RVContextButton(
                    book,
                    fullWidth: 74,
                    icon: startReadingIcon,
                    text: 'Resume',
                    action: (toogleFlag) async {
                      final lastChapterId = storage
                          .state.appData.history[book.id]!.lastReadChapterId;
                      final offset = storage.state.appData.history[book.id]!
                          .chapterHistory[lastChapterId]!.position;
                      context.reader.readChapter(
                        book,
                        lastChapterId,
                        offset,
                      );
                      context.navigator.goToCustomScaffold(
                        context,
                        scaffold: const ChapterView(),
                      );
                    },
                  )
                : RVContextButton(
                    book,
                    fullWidth: 74,
                    icon: startReadingIcon,
                    text: 'Start',
                    action: (toogleFlag) async {
                      context.reader.readChapter(book, book.chapters!.last.id);
                      context.navigator.goToCustomScaffold(
                        context,
                        scaffold: const ChapterView(),
                      );
                    },
                  )
            : const SizedBox.shrink()
        : RVContextButton(
            book,
            fullWidth: 70,
            icon: addToLibraryIcon,
            text: 'Library',
            action: (toogleFlag) {
              toogleFlag();
              LibraryService.addToLibrary(
                context.storageCubit,
                book: book,
              );
              toogleFlag();
            },
          );
  }
}
