import 'package:flutter/material.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../constants/measures.dart' as const_measures;
import '../l10n/l10n.dart';
import 'amount_bar.dart';
import 'common.dart';
import 'widgets.dart';

const pizzaSettingCardExtent = 270.0;

class PizzaSettingCard extends StatefulWidget {
  const PizzaSettingCard({
    super.key,
    required this.wrapper,
    required this.onValidChanged,
  });

  final PizzaWrapper wrapper;
  final void Function(bool isValid, [PizzaWrapper? wrapper]) onValidChanged;

  @override
  State<PizzaSettingCard> createState() => _PizzaSettingCardState();
}

class _PizzaSettingCardState extends State<PizzaSettingCard> {
  late final ValueNotifier<int> _amountNotifier;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  final _formKey = GlobalKey<FormState>();
  var _isValid = false;
  late PizzaWrapper _newWrapper;

  @override
  void initState() {
    super.initState();

    _amountNotifier = ValueNotifier(widget.wrapper.maxAmount)
      ..addListener(_onChanged);
    _nameController = TextEditingController(text: widget.wrapper.title);
    _nameController.addListener(_onChanged);
    _priceController =
        TextEditingController(text: beautifyCost(widget.wrapper.price));
    _priceController.addListener(_onChanged);
    _newWrapper = widget.wrapper.copyWith();
  }

  void _onChanged() {
    if (_formKey.currentState?.validate() == true) {
      _newWrapper = _newWrapper.copyWith(
        title: _nameController.text,
        price: double.parse(_priceController.text),
        // TODO: add image url
        imageUrl: '',
        amount: widget.wrapper.amount,
        maxAmount: _amountNotifier.value,
      );

      widget.onValidChanged(
        true,
        _newWrapper,
      );

      if (!_isValid) {
        _isValid = true;
      }
    } else {
      if (_isValid) {
        _isValid = false;
        widget.onValidChanged(false);
      }
    }
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
      height: pizzaSettingCardExtent,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.name,
                      style: theme.textTheme.headline6,
                    ),
                    TextFormField(
                      controller: _nameController,
                      // validator provides previous controller.text, so I need to pass current text manually
                      validator: (_) =>
                          _nameValidator(_nameController.text, l10n.invalid),
                      decoration: InputDecoration(
                        suffixIcon: SizedBox(
                          height: const_measures.smallButtonSize,
                          width: const_measures.smallButtonSize,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: theme.hintColor,
                            ),
                            onPressed: _nameController.clear,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      l10n.price,
                      style: theme.textTheme.headline6,
                    ),
                    TextFormField(
                      controller: _priceController,
                      // validator provides previous controller.text, so I need to pass current text manually
                      validator: (_) =>
                          _priceValidator(_priceController.text, l10n.invalid),
                      decoration: InputDecoration(
                        suffixIcon: SizedBox(
                          height: const_measures.smallButtonSize,
                          width: const_measures.smallButtonSize,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: theme.hintColor,
                            ),
                            onPressed: _priceController.clear,
                          ),
                        ),
                      ),
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

  String? _nameValidator(String? value, String error) {
    if (value?.isNotEmpty == true) {
      return null;
    }

    return error;
  }

  String? _priceValidator(String? value, String error) {
    if (value?.isNotEmpty == true) {
      if (value != null) {
        try {
          double.parse(value);
          return null;
        } catch (e) {
          return error;
        }
      }
    }

    return error;
  }
}
