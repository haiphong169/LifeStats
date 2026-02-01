import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/experience_bar.dart';

class AttributeDisplay extends StatelessWidget {
  const AttributeDisplay({super.key, required this.attribute});

  final Attribute attribute;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(attribute.attributeType.icon, height: 45, width: 45),
          Text(attribute.attributeType.name),
          Text(attribute.level.toString()),
          AnimatedExperienceBar(progress: attribute.progress),
        ],
      ),
    );
  }
}
