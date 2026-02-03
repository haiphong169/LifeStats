// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttributeTypeAdapter extends TypeAdapter<AttributeType> {
  @override
  final int typeId = 0;

  @override
  AttributeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AttributeType.strength;
      case 1:
        return AttributeType.intelligence;
      case 2:
        return AttributeType.luck;
      case 3:
        return AttributeType.charisma;
      default:
        return AttributeType.strength;
    }
  }

  @override
  void write(BinaryWriter writer, AttributeType obj) {
    switch (obj) {
      case AttributeType.strength:
        writer.writeByte(0);
        break;
      case AttributeType.intelligence:
        writer.writeByte(1);
        break;
      case AttributeType.luck:
        writer.writeByte(2);
        break;
      case AttributeType.charisma:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
