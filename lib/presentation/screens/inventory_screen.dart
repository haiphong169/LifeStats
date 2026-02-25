import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/character_class_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/inventory_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/item/item.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/item/weapon.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inventory")),
      body: Consumer2<CharacterClassNotifier, InventoryNotifier>(
        builder: (context, characterClass, inventory, _) {
          unequipItem(item) {
            if (item == null) {
              return;
            }
            inventory.unequipItem(item);
          }

          final weapon =
              inventory.equippedItems.whereType<Weapon>().firstOrNull;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 250,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            characterClass.characterClass!.classImage,
                            width: 120,
                            height: 120,
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                EquippedItemSlot(
                                  item: weapon,
                                  onTap: () {
                                    unequipItem(weapon);
                                  },
                                ),
                                Spacer(),
                                EquippedItemSlot(),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                EquippedItemSlot(),
                                Spacer(),
                                EquippedItemSlot(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: 0.5,
                      children:
                          inventory.unequippedItems
                              .map(
                                (item) => InventoryItemCard(
                                  item: item,
                                  onTap: () {
                                    inventory.equipItem(item);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class InventoryItemCard extends StatelessWidget {
  const InventoryItemCard({super.key, required this.item, required this.onTap});

  final Item item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
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
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EquippedItemSlot extends StatelessWidget {
  const EquippedItemSlot({super.key, this.item, this.onTap});

  final Item? item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 75,
        height: 75,
        color: Colors.grey,
        child:
            item == null
                ? null
                : Center(child: Image.asset(item!.imageUrl, height: 50)),
      ),
    );
  }
}
