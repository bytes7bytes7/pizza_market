import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;
import '../l10n/l10n.dart';
import 'common.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.costNotifier,
    required this.onPressed,
  });

  final ValueNotifier<double> costNotifier;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(
        const_measures.bigPadding,
      ),
      margin: const EdgeInsets.all(
        const_measures.bigPadding,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.total,
                style: theme.textTheme.bodyText1?.copyWith(
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
              ValueListenableBuilder<double>(
                valueListenable: costNotifier,
                builder: (context, value, child) {
                  return Text(
                    '\$${beautifyCost(value)}',
                    style: theme.textTheme.headline6?.copyWith(
                      color: theme.scaffoldBackgroundColor,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: const_measures.smallPadding,
          ),
          ValueListenableBuilder<double>(
            valueListenable: costNotifier,
            child: Text(
              l10n.placeOrder,
              style: theme.textTheme.button?.copyWith(
                color: theme.primaryColor,
              ),
            ),
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: value != 0 ? onPressed : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    theme.scaffoldBackgroundColor,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(
                      const_measures.bigPadding,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        const_measures.largeRadius,
                      ),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.all(
                    theme.disabledColor.withOpacity(
                      const_measures.smallOpacity,
                    ),
                  ),
                ),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }
}
