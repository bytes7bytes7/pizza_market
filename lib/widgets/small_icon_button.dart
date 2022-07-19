import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  const SmallIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: iconColor,
      ),
      color: backgroundColor,
      onPressed: onPressed,
    );
  }
}
