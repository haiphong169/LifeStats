// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_experience_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterExperienceDtoAdapter
    extends TypeAdapter<CharacterExperienceDto> {
  @override
  final int typeId = 3;

  @override
  CharacterExperienceDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterExperienceDto(
      level: fields[0] as int,
      currentExp: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterExperienceDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.currentExp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterExperienceDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
