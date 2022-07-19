import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;
import 'secondary_button.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      icon: Icons.arrow_back_ios_new_rounded,
      buttonSize: const_measures.midButtonSize,
      iconSize: const_measures.midIconSize,
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
