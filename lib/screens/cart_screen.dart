import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();

    _pizzaBloc = context.read<PizzaBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.orderDetails,
      ),
      body: Stack(
        children: [
          BlocBuilder<PizzaBloc, PizzaState>(
            builder: (context, state) {
              if (state is PizzaInitState) {
                _pizzaBloc.add(const PizzaLoadEvent());
              }

              if (state is PizzaDataState) {
                final inCart =
                    state.wrappers.where((e) => e.amount > 0).toList();

                if (inCart.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.empty,
                      style: theme.textTheme.headline6,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: inCart.length,
                  itemBuilder: (context, index) {
                    return PizzaControlCard(
                      wrapper: inCart[index],
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
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: OrderCard(
              cost: 10,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
