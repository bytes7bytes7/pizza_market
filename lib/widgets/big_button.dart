import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: const_measures.bigPadding,
        vertical: const_measures.midPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.disabledColor,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(
          const_measures.bigRadius,
        ),
      ),
      child: IntrinsicHeight(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            padding: const EdgeInsets.all(
              const_measures.bigPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                const_measures.bigRadius,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
