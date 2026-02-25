import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/inventory_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/item/item.dart';
import 'package:rpg_self_improvement_app/utils/shop_items.dart';

class ShopNotifier with ChangeNotifier {
  late InventoryNotifier _inventoryNotifier;

  final List<Item> _shopItems = INITIAL_ITEMS;

  Set<String> _soldOutItems = {};

  void update(InventoryNotifier inventoryNotifier) {
    _inventoryNotifier = inventoryNotifier;
    _soldOutItems =
        _inventoryNotifier.inventoryItems.map((item) => item.name).toSet();
    notifyListeners();
  }

  List<Item> get availableItems =>
      _shopItems.where((i) => !_soldOutItems.contains(i.name)).toList();
}
