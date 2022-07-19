import 'package:flutter/material.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../constants/measures.dart' as const_measures;
import 'common.dart';

class PizzaPreviewCard extends StatelessWidget {
  const PizzaPreviewCard({
    super.key,
    required this.wrapper,
    required this.onPressed,
  });

  final PizzaWrapper wrapper;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: const_measures.bigPadding,
        vertical: const_measures.midPadding,
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
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            padding: const EdgeInsets.all(
              const_measures.smallPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                const_measures.bigRadius,
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: const_measures.smallImageSize,
                width: const_measures.smallImageSize,
                child: (wrapper.imageUrl.isNotEmpty)
                    ? Image.network(
                        wrapper.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, trace) {
                          return const Icon(Icons.photo);
                        },
                      )
                    : const Icon(Icons.local_pizza_outlined),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: const_measures.bigPadding,
                  ),
                  child: Text(
                    wrapper.title,
                    maxLines: 2,
                    style: theme.textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                '\$${beautifyCost(wrapper.price)}',
                style: theme.textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}