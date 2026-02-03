// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitDtoAdapter extends TypeAdapter<HabitDto> {
  @override
  final int typeId = 1;

  @override
  HabitDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitDto(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      lastCompletedTimestamp: fields[3] as int?,
      attributeType: fields[4] as AttributeType,
    );
  }

  @override
  void write(BinaryWriter writer, HabitDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.lastCompletedTimestamp)
      ..writeByte(4)
      ..write(obj.attributeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
