import 'package:flutter/material.dart';

class UserActionButton extends StatelessWidget {
  const UserActionButton({
    super.key,
    required this.iconImageUrl,
    required this.label,
    required this.onPressed,
  });

  final String iconImageUrl;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Image.asset(iconImageUrl, height: 30),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
