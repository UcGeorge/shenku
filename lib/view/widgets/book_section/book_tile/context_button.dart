import 'package:flutter/material.dart';

import '../../../../constants/icons.dart';
import '../../../../data/models/book.dart';
import '../../../../logic/cubit/storage_cubit.dart';
import '../../../../logic/services/library.dart';
import 'rv_context_button.dart';

class BookTileContextButton extends StatelessWidget {
  const BookTileContextButton(this.book, this.context, {Key? key})
      : super(key: key);

  final Book book;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    bool isInLibrary = context.appData.library.contains(book);

    return isInLibrary
        ? RVContextButton(
            book,
            fullWidth: 74,
            icon: startReadingIcon,
            text: 'Start',
            action: (toogleFlag) async {
              //TODO: Implement chapters
            },
          )
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
