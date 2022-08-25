part of 'storage_cubit.dart';

class StorageState extends Equatable {
  StorageState({
    AppData? appData,
  })  : appData = appData ?? AppData.empty(),
        stateId = const Uuid().v1();

  factory StorageState.init() => StorageState();

  final AppData appData;
  final String stateId;

  @override
  List<Object> get props => [stateId];

  @override
  String toString() => "AppData: $stateId";

  StorageState copyWith({
    AppData? appData,
  }) {
    return StorageState(
      appData: appData ?? this.appData,
    );
  }
}
