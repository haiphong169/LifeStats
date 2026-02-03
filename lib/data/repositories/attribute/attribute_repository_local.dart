import 'package:hive/hive.dart';
import 'package:rpg_self_improvement_app/data/dto/attribute_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/attribute/attribute_repository.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

class AttributeRepositoryLocal extends AttributeRepository {
  static const _boxName = 'attribute_box';

  Future<Box<AttributeDto>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<AttributeDto>(_boxName);
    }
    return await Hive.openBox<AttributeDto>(_boxName);
  }

  @override
  Future<List<AttributeDto>> setUpInitialAttributes() async {
    final box = await _openBox();

    final initialAttributes = [
      AttributeDto(
        attributeType: AttributeType.strength,
        currentExp: 0,
        level: 1,
      ),
      AttributeDto(
        attributeType: AttributeType.intelligence,
        currentExp: 0,
        level: 1,
      ),
      AttributeDto(attributeType: AttributeType.luck, currentExp: 0, level: 1),
      AttributeDto(
        attributeType: AttributeType.charisma,
        currentExp: 0,
        level: 1,
      ),
    ];

    for (final attribute in initialAttributes) {
      await box.put(attribute.attributeType.name, attribute);
    }

    return initialAttributes;
  }

  @override
  Future<List<AttributeDto>> fetchAttributes() async {
    final box = await _openBox();
    return box.values.toList();
  }

  @override
  Future<void> updateAttributeExp(AttributeDto updatedAttribute) async {
    final box = await _openBox();
    await box.put(updatedAttribute.attributeType.name, updatedAttribute);
  }
}
