part of 'soal_bloc.dart';

@immutable
abstract class SoalEvent {}

class SoalGetListEvent extends SoalEvent {
  final bool refresh;

  SoalGetListEvent({this.refresh = false});
}

class SoalTambahEvent extends SoalEvent {
  final Map<String, dynamic> json;

  SoalTambahEvent(this.json);
}

class SoalEditEvent extends SoalEvent {
  final Map<String, dynamic> json;
  SoalEditEvent(this.json);
}

class SoalDeleteEvent extends SoalEvent {
  final int id;

  SoalDeleteEvent(this.id);
}

class SoalGetEvent extends SoalEvent {
  final int id;

  SoalGetEvent(this.id);
}

class SoalSetStatusEvent extends SoalEvent {
  final int id;
  final int status;

  SoalSetStatusEvent(this.id, this.status);
}
