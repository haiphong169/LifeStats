// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_class_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterClassDtoAdapter extends TypeAdapter<CharacterClassDto> {
  @override
  final int typeId = 5;

  @override
  CharacterClassDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterClassDto(
      characterClass: fields[0] as CharacterClass,
      lastPickedAtAttributeLevel: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterClassDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.characterClass)
      ..writeByte(1)
      ..write(obj.lastPickedAtAttributeLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterClassDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharacterClassAdapter extends TypeAdapter<CharacterClass> {
  @override
  final int typeId = 4;

  @override
  CharacterClass read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CharacterClass.warrior;
      case 1:
        return CharacterClass.wizard;
      case 2:
        return CharacterClass.merchant;
      case 3:
        return CharacterClass.lover;
      case 4:
        return CharacterClass.normie;
      default:
        return CharacterClass.warrior;
    }
  }

  @override
  void write(BinaryWriter writer, CharacterClass obj) {
    switch (obj) {
      case CharacterClass.warrior:
        writer.writeByte(0);
        break;
      case CharacterClass.wizard:
        writer.writeByte(1);
        break;
      case CharacterClass.merchant:
        writer.writeByte(2);
        break;
      case CharacterClass.lover:
        writer.writeByte(3);
        break;
      case CharacterClass.normie:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
