// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_emails_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PastEmailsModelAdapter extends TypeAdapter<PastEmailsModel> {
  @override
  final int typeId = 2;

  @override
  PastEmailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PastEmailsModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      promptId: fields[2] as String,
      subject: fields[3] as String,
      keywords: fields[4] as String,
      generatedEmail: fields[5] as String,
      toEmailId: fields[6] as String,
      tokens: fields[7] as int,
      createdOn: fields[8] as int,
      v: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PastEmailsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.promptId)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.keywords)
      ..writeByte(5)
      ..write(obj.generatedEmail)
      ..writeByte(6)
      ..write(obj.toEmailId)
      ..writeByte(7)
      ..write(obj.tokens)
      ..writeByte(8)
      ..write(obj.createdOn)
      ..writeByte(9)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PastEmailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
