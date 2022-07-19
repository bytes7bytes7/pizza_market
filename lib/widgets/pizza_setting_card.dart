import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../blocs/blocs.dart';
import '../constants/measures.dart' as const_measures;
import '../l10n/l10n.dart';
import 'amount_bar.dart';

class PizzaSettingCard extends StatefulWidget {
  const PizzaSettingCard({
    super.key,
    required this.wrapper,
  });

  final PizzaWrapper wrapper;

  @override
  State<PizzaSettingCard> createState() => _PizzaSettingCardState();
}

class _PizzaSettingCardState extends State<PizzaSettingCard> {
  late final AdminBloc _adminBloc;
  late final ValueNotifier<int> _amountNotifier;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _adminBloc = context.read<AdminBloc>();
    _amountNotifier = ValueNotifier(widget.wrapper.maxAmount);
    _nameController = TextEditingController()..clear();
    _priceController = TextEditingController()..clear();
  }

  @override
  void dispose() {
    _amountNotifier.dispose();
    _nameController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: const_measures.largePadding,
      ),
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
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            Flexible(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.name,
                      style: theme.textTheme.headline6,
                    ),
                    TextFormField(
                      controller: _nameController,
                    ),
                    const SizedBox(
                      height: const_measures.bigPadding,
                    ),
                    Text(
                      l10n.price,
                      style: theme.textTheme.headline6,
                    ),
                    TextFormField(
                      controller: _priceController,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: AmountBar(
                notifier: _amountNotifier,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
