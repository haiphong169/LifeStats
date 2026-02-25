// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemDtoAdapter extends TypeAdapter<ItemDto> {
  @override
  final int typeId = 6;

  @override
  ItemDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemDto(
      name: fields[0] as String,
      isEquipped: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ItemDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isEquipped);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
