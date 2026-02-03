import 'package:rpg_self_improvement_app/data/dto/attribute_dto.dart';

abstract class AttributeRepository {
  Future<List<AttributeDto>> setUpInitialAttributes();

  Future<List<AttributeDto>> fetchAttributes();

  Future<void> updateAttributeExp(AttributeDto updatedAttribute);
}
