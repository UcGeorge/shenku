part of 'reading_cubit.dart';

class ReadingState extends Equatable {
  ReadingState(this.book, this.chapterId) : stateId = const Uuid().v1();

  factory ReadingState.init() => ReadingState(null, null);

  final Book? book;
  final String? chapterId;
  final String stateId;

  Chapter? get chapter =>
      book?.chapters!.firstWhere((element) => element.id == chapterId);

  @override
  List<Object> get props => [stateId];

  @override
  String toString() => "ReadingState: ${book?.name} / $chapterId";

  bool get hasState => book != null;

  ReadingState copyWith({
    Book? book,
    String? chapterId,
    String? stateId,
    int? loadedUnits,
  }) {
    return ReadingState(
      book ?? this.book,
      chapterId ?? this.chapterId,
    );
  }
}
