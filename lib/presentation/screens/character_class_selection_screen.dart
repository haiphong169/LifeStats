import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';

class CharacterClassSelectionScreen extends StatelessWidget {
  const CharacterClassSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Character Class Selection")),
      body: Center(
        child: Column(
          children:
              CharacterClass.values
                  .map(
                    (characterClass) => CharacterClassProfile(
                      assetUrl: characterClass.classImage,
                      onChoose: () {
                        context.read<GameMaster>().selectCharacterClass(
                          characterClass,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}

class CharacterClassProfile extends StatelessWidget {
  const CharacterClassProfile({
    super.key,
    required this.assetUrl,
    required this.onChoose,
  });

  final String assetUrl;
  final VoidCallback onChoose;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChoose,
      child: Image.asset(assetUrl, width: 100, height: 100),
    );
  }
}
