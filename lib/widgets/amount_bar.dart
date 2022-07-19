import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;
import 'primary_button.dart';
import 'secondary_button.dart';

class AmountBar extends StatelessWidget {
  const AmountBar({
    super.key,
    required this.notifier,
    this.max,
  });

  final ValueNotifier<int> notifier;
  final int? max;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_reachMin)
              SecondaryButton(
                icon: Icons.remove,
                onPressed: () {},
              )
            else
              PrimaryButton(
                icon: Icons.remove,
                onPressed: _decrement,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: const_measures.smallPadding,
              ),
              child: Text('$value'),
            ),
            if (_reachMax)
              SecondaryButton(
                icon: Icons.add,
                onPressed: () {},
              )
            else
              PrimaryButton(
                icon: Icons.add,
                onPressed: _increment,
              ),
          ],
        );
      },
    );
  }

  bool get _reachMin => notifier.value == 1;

  bool get _reachMax => notifier.value == (max ?? double.infinity);

  void _decrement() {
    final value = notifier.value;
    if (!_reachMin) {
      notifier.value = value - 1;
    }
  }

  void _increment() {
    final value = notifier.value;
    if (!_reachMax) {
      notifier.value = value + 1;
    }
  }
}
