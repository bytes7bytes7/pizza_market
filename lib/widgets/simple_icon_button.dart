import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;

class SimpleIconButton extends StatelessWidget {
  const SimpleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.buttonSize = const_measures.bigButtonSize,
    this.iconSize = const_measures.bigIconSize,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double buttonSize;
  final double iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              const_measures.smallButtonRadius,
            ),
            splashColor: theme.scaffoldBackgroundColor.withOpacity(
              const_measures.smallOpacity,
            ),
            onTap: onPressed,
            child: Icon(
              icon,
              size: iconSize,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
