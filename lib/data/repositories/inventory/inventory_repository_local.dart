import 'package:hive/hive.dart';
import 'package:rpg_self_improvement_app/data/dto/item_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/inventory/inventory_repository.dart';

class InventoryRepositoryLocal implements InventoryRepository {
  static const String _boxName = 'inventory_box';
  static const String _goldBoxName = 'gold_box';

  Future<Box<ItemDto>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<ItemDto>(_boxName);
    }
    return await Hive.openBox<ItemDto>(_boxName);
  }

  Future<Box<int>> _openGoldBox() async {
    if (Hive.isBoxOpen(_goldBoxName)) {
      return Hive.box<int>(_goldBoxName);
    }
    return await Hive.openBox<int>(_goldBoxName);
  }

  @override
  Future<void> buyItem(ItemDto newItem) async {
    final box = await _openBox();
    await box.put(newItem.name, newItem);
  }

  @override
  Future<List<ItemDto>> fetchOwnedItems() async {
    final box = await _openBox();

    return box.values.toList();
  }

  @override
  Future<void> equipItem(String itemName) async {
    final box = await _openBox();

    final item = box.get(itemName);
    // TODO: This too
    if (item != null) {
      final updatedItem = ItemDto(name: item.name, isEquipped: true);
      await box.put(itemName, updatedItem);
    }
  }

  @override
  Future<void> unequipItem(String itemName) async {
    final box = await _openBox();

    final item = box.get(itemName);
    // TODO: Handle case when item is not found
    if (item != null) {
      final updatedItem = ItemDto(name: item.name, isEquipped: false);
      await box.put(itemName, updatedItem);
    }
  }

  @override
  Future<void> updateGold(int change) async {
    final box = await _openGoldBox();
    final currentGold = box.get('gold') ?? 0;
    final newGold = currentGold + change;
    await box.put('gold', newGold);
  }

  @override
  Future<int> fetchGold() async {
    final box = await _openGoldBox();
    return box.get('gold') ?? 0;
  }
}
