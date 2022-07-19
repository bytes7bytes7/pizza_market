import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../blocs/blocs.dart';
import '../l10n/l10n.dart';
import '../widgets/widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final PizzaBloc _pizzaBloc;
  late final ValueNotifier<double> _costNotifier;
  late final ValueNotifier<List<PizzaWrapper>> _pizzasNotifier;

  @override
  void initState() {
    super.initState();

    _pizzaBloc = context.read<PizzaBloc>();
    _costNotifier = ValueNotifier(0);
    _pizzasNotifier = ValueNotifier([]);
  }

  @override
  void dispose() {
    _costNotifier.dispose();
    _pizzasNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.orderDetails,
      ),
      body: BlocBuilder<PizzaBloc, PizzaState>(
        builder: (context, state) {
          if (state is PizzaInitState) {
            _pizzaBloc.add(const PizzaLoadEvent());
          }

          if (state is PizzaDataState) {
            _costNotifier.value = state.cartCost;
            final inCart = state.wrappers.where((e) => e.amount > 0).toList();

            _pizzasNotifier.value = inCart;

            if (inCart.isEmpty) {
              return Center(
                child: Text(
                  l10n.empty,
                  style: theme.textTheme.headline6,
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: inCart.length,
                    itemBuilder: (context, index) {
                      final wrapper = inCart[index];

                      return PizzaControlCard(
                        wrapper: wrapper,
                        onChanged: (amount) {
                          var cartCost = state.cartCost;
                          cartCost += wrapper.price * (amount - 1);
                          _costNotifier.value = cartCost;
                          final newWrappers =
                              List<PizzaWrapper>.from(_pizzasNotifier.value);
                          newWrappers[index] = wrapper.copyWith(amount: amount);
                          _pizzasNotifier.value = newWrappers;
                          _pizzaBloc.add(
                            PizzaUpdateEvent(
                              wrappers: newWrappers,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                ValueListenableBuilder<List<PizzaWrapper>>(
                  valueListenable: _pizzasNotifier,
                  builder: (context, pizzas, child) {
                    if (pizzas.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return OrderCard(
                      costNotifier: _costNotifier,
                      onPressed: () {
                        _pizzaBloc.add(
                          PizzaOrderEvent(wrappers: pizzas),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          } else if (state is PizzaErrorState) {
            return ErrorLabel(
              error: state.error,
              stackTrace: state.stackTrace,
              buttonText: l10n.tryAgain,
              onPressed: () {
                _pizzaBloc.add(const PizzaLoadEvent());
              },
            );
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
