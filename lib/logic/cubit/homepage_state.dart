part of 'homepage_cubit.dart';

class HomepageState extends Equatable {
  HomepageState({
    List<Book>? library,
    Map<String, List<Book>?>? sourcesHomepage,
  })  : stateId = const Uuid().v4(),
        library = library ?? [],
        sourcesHomepage = sourcesHomepage ?? {};

  factory HomepageState.init() => HomepageState();

  final String stateId;
  final List<Book> library;
  final Map<String, List<Book>?> sourcesHomepage;

  @override
  List<Object> get props => [stateId];

  @override
  String toString() =>
      "HomepageState: $stateId, Library: ${library.length}, ${sourcesHomepage.map((key, value) => MapEntry(key, value?.length))}";

  HomepageState copyWith({
    String? stateId,
    List<Book>? library,
    Map<String, List<Book>?>? sourcesHomepage,
  }) {
    return HomepageState(
      library: library ?? this.library,
      sourcesHomepage: sourcesHomepage ?? this.sourcesHomepage,
    );
  }
}
