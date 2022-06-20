// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorials_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TutorialsModelAdapter extends TypeAdapter<TutorialsModel> {
  @override
  final int typeId = 3;

  @override
  TutorialsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TutorialsModel(
      title: fields[0] as String,
      htmlContent: fields[2] as String,
      updatedOn: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TutorialsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.htmlContent)
      ..writeByte(3)
      ..write(obj.updatedOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TutorialsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
