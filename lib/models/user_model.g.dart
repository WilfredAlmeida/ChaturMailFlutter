// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 4;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      generatedEmailCount: fields[0] as int,
      id: fields[1] as String,
      usedTokens: fields[2] as int,
      availableTokens: fields[3] as int,
      name: fields[4] as String,
      picture: fields[5] as String,
      userId: fields[6] as String,
      email: fields[7] as String,
      uid: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.generatedEmailCount)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.usedTokens)
      ..writeByte(3)
      ..write(obj.availableTokens)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.picture)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.uid);
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
