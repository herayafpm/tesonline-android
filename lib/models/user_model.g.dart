// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      user_id: fields[0] as int,
      user_username: fields[1] as String,
      user_nama: fields[2] as String,
      user_email: fields[3] as String,
      role_id: fields[4] as int,
      role_nama: fields[5] as String,
      token: fields[6] as String,
      is_admin: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.user_id)
      ..writeByte(1)
      ..write(obj.user_username)
      ..writeByte(2)
      ..write(obj.user_nama)
      ..writeByte(3)
      ..write(obj.user_email)
      ..writeByte(4)
      ..write(obj.role_id)
      ..writeByte(5)
      ..write(obj.role_nama)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.is_admin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
