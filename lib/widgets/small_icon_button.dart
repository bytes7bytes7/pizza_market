import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;

class SmallIconButton extends StatelessWidget {
  const SmallIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.radius = const_measures.smallButtonRadius,
    this.size = const_measures.smallIconSize,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double radius;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: size,
        width: size,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            alignment: Alignment.center,
            padding: MaterialStateProperty.all(
              EdgeInsets.zero,
            ),
            backgroundColor: MaterialStateProperty.all(
              backgroundColor,
            ),
          ),
          child: Icon(icon),
        ),
      ),
    );
    return Container(

      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
