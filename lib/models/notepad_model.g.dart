// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notepad_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotePadModelAdapter extends TypeAdapter<NotePadModel> {
  @override
  final int typeId = 1;

  @override
  NotePadModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotePadModel(
      key: fields[0] as int?,
      title: fields[1] as String,
      description: fields[2] as String,
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotePadModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotePadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
