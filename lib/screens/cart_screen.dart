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

  @override
  void initState() {
    super.initState();

    _pizzaBloc = context.read<PizzaBloc>();
    _costNotifier = ValueNotifier(0);
  }

  @override
  void dispose() {
    _costNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    var hasData = false;

    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.orderDetails,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<PizzaBloc, PizzaState>(
              buildWhen: (prev, curr) {
                return !hasData;
              },
              builder: (context, state) {
                if (state is PizzaInitState) {
                  _pizzaBloc.add(const PizzaLoadEvent());
                }

                if (state is PizzaDataState) {
                  hasData = true;

                  final inCart =
                      state.wrappers.where((e) => e.amount > 0).toList();

                  _costNotifier.value = _calcCost(inCart);

                  if (inCart.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.empty,
                        style: theme.textTheme.headline6,
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: inCart.length,
                    itemBuilder: (context, index) {
                      return PizzaControlCard(
                        wrapper: inCart[index],
                        onChanged: (delta) {
                          _costNotifier.value += delta;
                        },
                      );
                    },
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
          ),
          ValueListenableBuilder<double>(
            valueListenable: _costNotifier,
            builder: (context, value, child) {
              if (value == 0) {
                return const SizedBox.shrink();
              }

              return OrderCard(
                costNotifier: _costNotifier,
                onPressed: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  double _calcCost(List<PizzaWrapper> wrappers) {
    return wrappers.fold<double>(
      0,
      (prev, curr) => prev + curr.price * curr.amount,
    );
  }
}
