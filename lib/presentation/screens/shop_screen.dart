import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/inventory_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/shop_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/item/item.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<InventoryNotifier, int>(
                selector: (_, inventoryNotifier) => inventoryNotifier.gold,
                builder:
                    (context, gold, child) => Align(
                      alignment: Alignment.centerRight,
                      child: Text("Gold: $gold"),
                    ),
              ),
              Consumer<ShopNotifier>(
                builder: (context, shopNotifier, child) {
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children:
                          shopNotifier.availableItems
                              .map(
                                (item) => ItemCard(
                                  item: item,
                                  onBuy: () {
                                    var successfulBuy = context
                                        .read<GameMaster>()
                                        .buyItem(item);
                                    if (!successfulBuy) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Not enough gold!"),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, required this.onBuy});

  final Item item;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBuy,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(item.imageUrl, height: 50),
            SizedBox(height: 8),
            Text(item.name),
            SizedBox(height: 4),
            Text(
              item.description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text("Price: ${item.price}"),
          ],
        ),
      ),
    );
  }
}
