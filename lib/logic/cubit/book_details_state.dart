part of 'book_details_cubit.dart';

class BookDetailsState extends Equatable {
  BookDetailsState(this.book) : stateId = const Uuid().v1();

  factory BookDetailsState.init() => BookDetailsState(null);

  final Book? book;
  final String stateId;

  @override
  List<Object> get props => [stateId];

  @override
  String toString() => "BookDetails: ${book?.name}";

  bool get hasState => book != null;

  BookDetailsState copyWith({
    Book? book,
  }) {
    return BookDetailsState(
      book,
    );
  }
}
