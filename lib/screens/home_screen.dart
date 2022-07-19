import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../constants/routes.dart' as const_routes;
import '../l10n/l10n.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: l10n.appName,
        leading: null,
        action: Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  theme.primaryColor,
                  theme.disabledColor,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ).createShader(bounds),
              child: SimpleIconButton(
                icon: Icons.shopping_basket,
                onPressed: () {
                  Navigator.of(context).pushNamed(const_routes.cart);
                },
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  theme.primaryColor,
                  theme.disabledColor,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ).createShader(bounds),
              child: SimpleIconButton(
                icon: Icons.person,
                onPressed: () {
                  Navigator.of(context).pushNamed(const_routes.admin);
                },
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<PizzaBloc, PizzaState>(
        builder: (context, state) {
          if (state is PizzaInitState) {
            _pizzaBloc.add(const PizzaLoadEvent());
          }

          if (state is PizzaDataState) {
            final notInCart =
                state.wrappers.where((e) => e.amount == 0).toList();

            if (notInCart.isEmpty) {
              return Center(
                child: Text(
                  l10n.empty,
                  style: theme.textTheme.headline6,
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notInCart.length,
              itemBuilder: (context, index) {
                final wrapper = notInCart[index];

                return PizzaPreviewCard(
                  wrapper: wrapper,
                  onPressed: () {
                    _pizzaBloc.add(
                      PizzaPickEvent(wrapper: wrapper),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          l10n.addedToCart(wrapper.title),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: theme.primaryColor,
                        duration: const Duration(seconds: 1),
                      ),
                    );
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
    );
  }
}
