// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttributeDtoAdapter extends TypeAdapter<AttributeDto> {
  @override
  final int typeId = 2;

  @override
  AttributeDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttributeDto(
      level: fields[0] as int,
      currentExp: fields[1] as int,
      attributeType: fields[2] as AttributeType,
    );
  }

  @override
  void write(BinaryWriter writer, AttributeDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.currentExp)
      ..writeByte(2)
      ..write(obj.attributeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
