import 'package:flutter/material.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../constants/measures.dart' as const_measures;
import 'amount_bar.dart';
import 'common.dart';

class PizzaControlCard extends StatefulWidget {
  const PizzaControlCard({
    super.key,
    required this.wrapper,
    required this.onChanged,
  });

  final PizzaWrapper wrapper;
  final void Function(int amount) onChanged;

  @override
  State<PizzaControlCard> createState() => _PizzaControlCardState();
}

class _PizzaControlCardState extends State<PizzaControlCard> {
  late final ValueNotifier<int> _amountNotifier;

  @override
  void initState() {
    super.initState();

    _amountNotifier = ValueNotifier(widget.wrapper.amount)
      ..addListener(() {
        widget.onChanged(_amountNotifier.value);
      });
  }

  @override
  void dispose() {
    _amountNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: const_measures.bigPadding,
        vertical: const_measures.midPadding,
      ),
      padding: const EdgeInsets.all(
        const_measures.smallPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          const_measures.midRadius,
        ),
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            offset: const_measures.shadowOffset,
            blurRadius: const_measures.blurRadius,
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: const_measures.midImageSize,
              width: const_measures.midImageSize,
              child: (widget.wrapper.imageUrl.isNotEmpty)
                  ? Image.network(
                      widget.wrapper.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, trace) {
                        return const Icon(Icons.photo);
                      },
                    )
                  : const Icon(Icons.local_pizza_outlined),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: const_measures.bigPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.wrapper.title,
                        maxLines: 2,
                        style: theme.textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '\$${beautifyCost(widget.wrapper.price)}',
                        style: theme.textTheme.headline6?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AmountBar(
              notifier: _amountNotifier,
              max: widget.wrapper.maxAmount,
            ),
          ],
        ),
      ),
    );
  }
}
