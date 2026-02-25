import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/data/dto/item_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/inventory/inventory_repository.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/item/item.dart';
import 'package:rpg_self_improvement_app/utils/adapters/mapper_helper.dart';
import 'package:rpg_self_improvement_app/utils/constants.dart';

class InventoryNotifier with ChangeNotifier {
  final InventoryRepository _inventoryRepository;

  InventoryNotifier(this._inventoryRepository);

  List<Item> _inventoryItems = [];
  int _gold = 0;

  UnmodifiableListView<Item> get inventoryItems =>
      UnmodifiableListView(_inventoryItems);

  UnmodifiableListView<Item> get equippedItems =>
      UnmodifiableListView(_inventoryItems.where((item) => item.isEquipped));

  UnmodifiableListView<Item> get unequippedItems =>
      UnmodifiableListView(_inventoryItems.where((item) => !item.isEquipped));

  int get gold => _gold;

  Future<void> loadInventory() async {
    final ownedItemsResponse = await _inventoryRepository.fetchOwnedItems();
    final goldResponse = await _inventoryRepository.fetchGold();
    _inventoryItems =
        ownedItemsResponse
            .map((item) => MapperHelper.fromItemDto(item))
            .toList();
    _gold = goldResponse;
    notifyListeners();
  }

  Future<void> buyItem(Item item) async {
    _inventoryRepository.buyItem(ItemDto(name: item.name, isEquipped: false));
    _inventoryRepository.updateGold(-item.price);
    _inventoryItems.add(item);
    _gold -= item.price;
    notifyListeners();
  }

  Future<void> completeHabit() async {
    await _inventoryRepository.updateGold(GOLD_PER_HABIT_COMPLETION);
    _gold += GOLD_PER_HABIT_COMPLETION;
    notifyListeners();
  }

  Future<void> equipItem(Item item) async {
    if (equippedItems.any((it) => it.runtimeType == item.runtimeType)) return;
    await _inventoryRepository.equipItem(item.name);
    int index = _inventoryItems.indexWhere((i) => i.name == item.name);
    if (index != -1) {
      _inventoryItems[index] = _inventoryItems[index].equippedItem();
    }
    notifyListeners();
  }

  Future<void> unequipItem(Item item) async {
    await _inventoryRepository.unequipItem(item.name);
    int index = _inventoryItems.indexWhere((i) => i.name == item.name);
    if (index != -1) {
      _inventoryItems[index] = _inventoryItems[index].unequippedItem();
    }
    notifyListeners();
  }
}
