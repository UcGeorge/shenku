import '../../data/models/book.dart';
import '../cubit/storage_cubit.dart';

class LibraryService {
  static void addToLibrary(StorageCubit storageCubit, {required Book book}) {
    var appData = storageCubit.state.appData;
    var bookInLibrary = storageCubit.state.appData.library.contains(book);

    if (!bookInLibrary) {
      storageCubit.modifyAppData(appData.copyWith(
        library: appData.library..add(book),
      ));
    }
  }

  static void removeFromLibrary(StorageCubit storageCubit,
      {required Book book}) {
    var appData = storageCubit.state.appData;
    var bookInLibrary = storageCubit.state.appData.library.contains(book);

    if (bookInLibrary) {
      storageCubit.modifyAppData(appData.copyWith(
        library: appData.library..remove(book),
      ));
    }
  }
}
