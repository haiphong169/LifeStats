import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/utils/adapters/mapper_helper.dart';

class CharacterClassProfile extends StatelessWidget {
  const CharacterClassProfile({super.key, required this.characterClass});

  final CharacterClass characterClass;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  characterClass.name.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                characterClass != CharacterClass.normie
                    ? Image.asset(
                      MapperHelper.getAssociatedAttributeForCharacterClass(
                        characterClass,
                      )!.icon,
                      height: 40,
                    )
                    : SizedBox(),
              ],
            ),
            Image.asset(characterClass.classImage, height: 200),
            Text(
              characterClass.classEffectDescription,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
