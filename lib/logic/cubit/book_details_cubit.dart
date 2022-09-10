import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import '../../config/config.dart';
import 'storage_cubit.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/book.dart';

part 'book_details_state.dart';

final _log = Logger('book_details_cubit');

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsState.init());

  @override
  void emit(BookDetailsState state) {
    // _log.info(state);
    super.emit(state);
  }

  void showDetails(Book book) => emit(state.copyWith(book: book));

  void clearDetails() => emit(state.copyWith(book: null));

  Future<void> getBookDetails(BuildContext context) async {
    if (state.book == null) return;
    if (state.book!.hasCompleteData) return;

    _log.info('Getting book details for ${state.book?.name}');
    Book book = state.book!;
    String source = book.source;

    Book detailedBook = book.merge(
      await appBookSources.getSource(source).getBookDetails(
            book,
            fields: book.missingFields,
          ),
      fields: book.missingFields,
    );

    if (detailedBook == state.book) emit(state.copyWith(book: detailedBook));

    final bookInLibrary = context.appData.library.contains(detailedBook);
    if (bookInLibrary) {
      context.storageCubit.modifyAppData(
        context.appData.copyWith(
          library: context.appData.library
            ..remove(book)
            ..insert(0, detailedBook),
        ),
      );
    }
  }
}

extension BookDetails on BuildContext {
  BookDetailsCubit get detailsController => read<BookDetailsCubit>();
}
