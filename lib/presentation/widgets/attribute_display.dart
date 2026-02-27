import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/experience_bar.dart';

class AttributeDisplay extends StatelessWidget {
  const AttributeDisplay({super.key, required this.attribute});

  final Attribute? attribute;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (attribute == null) {
      return SizedBox(
        width: screenWidth * 0.4,
        child: Column(
          children: [
            Container(
              width: 45,
              height: 45,
              color: Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(height: 8),
            Container(
              width: 80,
              height: 16,
              color: Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(height: 4),
            Container(
              width: 100,
              height: 12,
              color: Theme.of(context).colorScheme.surface,
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: screenWidth * 0.4,
      child: Row(
        children: [
          Image.asset(attribute!.attributeType.icon, height: 45),
          Expanded(
            child: Column(
              children: [
                Text(
                  attribute!.attributeType.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  "Level ${attribute!.level}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      "${attribute!.currentXp}/${attribute!.xpForNextLevel}",
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: AnimatedExperienceBar(
                        progress: attribute!.progress,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
