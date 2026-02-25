import 'package:rpg_self_improvement_app/data/dto/item_dto.dart';

abstract class InventoryRepository {
  Future<void> buyItem(ItemDto newItem);
  Future<void> equipItem(String itemName);
  Future<void> unequipItem(String itemName);
  Future<List<ItemDto>> fetchOwnedItems();
  Future<void> updateGold(int change);
  Future<int> fetchGold();
}
