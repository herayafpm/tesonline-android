part of 'soal_bloc.dart';

@immutable
abstract class SoalState {}

class SoalInitial extends SoalState {}

class SoalStateLoading extends SoalState {}

class SoalStateSuccess extends SoalState {
  final Map<String, dynamic> data;

  SoalStateSuccess(this.data);
}

class SoalFormSuccess extends SoalState {
  final Map<String, dynamic> data;

  SoalFormSuccess(this.data);
}

class SoalStateError extends SoalState {
  final Map<String, dynamic> errors;

  SoalStateError(this.errors);
}

class SoalListLoaded extends SoalState {
  List<dynamic> soals;
  bool hasReachMax;

  SoalListLoaded({this.soals, this.hasReachMax});
  SoalListLoaded copyWith({List<dynamic> soals, bool hasReachMax}) {
    return SoalListLoaded(
        soals: soals ?? this.soals,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}
