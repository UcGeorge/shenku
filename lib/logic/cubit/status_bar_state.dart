part of 'status_bar_cubit.dart';

class StatusBarState extends Equatable {
  StatusBarState(
    this.lItems,
    this.rItems,
  ) : stateId = const Uuid().v1();

  factory StatusBarState.init() => StatusBarState({}, {});

  final String stateId;
  final Map<String, Widget> lItems;
  final Map<String, Widget> rItems;

  @override
  List<Object> get props => [stateId];

  StatusBarState copyWith({
    String? stateId,
    Map<String, Widget>? lItems,
    Map<String, Widget>? rItems,
  }) {
    return StatusBarState(
      lItems ?? this.lItems,
      rItems ?? this.rItems,
    );
  }
}
