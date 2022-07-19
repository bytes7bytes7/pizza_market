import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.buttonSize = const_measures.smallButtonSize,
    this.iconSize = const_measures.smallIconSize,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double buttonSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              const_measures.smallButtonRadius,
            ),
            color: theme.disabledColor.withOpacity(
              const_measures.smallOpacity,
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              icon,
              size: iconSize,
              color: theme.primaryColor.withOpacity(
                const_measures.midOpacity,
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
