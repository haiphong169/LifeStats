import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/character_class_profile.dart';

class CharacterClassSelectionScreen extends StatefulWidget {
  const CharacterClassSelectionScreen({super.key});

  @override
  State<CharacterClassSelectionScreen> createState() =>
      _CharacterClassSelectionScreenState();
}

class _CharacterClassSelectionScreenState
    extends State<CharacterClassSelectionScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.6, initialPage: 1);
  }

  @override
  dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                context.read<GameMaster>().selectCharacterClass(
                  CharacterClass.values[_currentIndex],
                );
                Navigator.pop(context);
              },
              child: Text(
                'Select',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: CharacterClass.values.length,
                    onPageChanged:
                        (index) => setState(() {
                          _currentIndex = index;
                        }),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CharacterClassProfile(
                          characterClass: CharacterClass.values[index],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed:
                          _currentIndex > 0
                              ? () => _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              )
                              : null,
                      icon: Icon(Icons.chevron_left),
                      iconSize: 48,
                    ),
                    IconButton(
                      onPressed:
                          _currentIndex < CharacterClass.values.length - 1
                              ? () => _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              )
                              : null,
                      icon: Icon(Icons.chevron_right),
                      iconSize: 48,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDotIndicators(),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        CharacterClass.values.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentIndex == index ? 16.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color:
                _currentIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
