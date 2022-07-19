import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pizza/pizza_bloc.dart';
import '../constants/routes.dart' as const_routes;
import '../l10n/l10n.dart';
import '../widgets/widget.dart';

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
      appBar: AppBar(
        centerTitle: false,
        title: Text(l10n.appName),
        actions: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                theme.primaryColor,
                theme.disabledColor,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ).createShader(bounds),
            child: IconButton(
              icon: const Icon(Icons.shopping_basket),
              onPressed: () {},
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
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).pushNamed(const_routes.admin);
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<PizzaBloc, PizzaState>(
        builder: (context, state) {
          if (state is PizzaInitState) {
            _pizzaBloc.add(const PizzaLoadEvent());
          }

          if (state is PizzaDataState) {
            final wrappers = state.wrappers;

            if (wrappers.isEmpty) {
              return Center(
                child: Text(
                  l10n.empty,
                  style: theme.textTheme.headline6,
                ),
              );
            }

            return ListView.builder(
              itemCount: wrappers.length,
              itemBuilder: (context, index) {
                final wrapper = wrappers[index];

                return ListTile(
                  title: Text(wrapper.title),
                  leading: wrapper.imageUrl.isNotEmpty
                      ? Image.network(
                          wrapper.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, trace) {
                            return const Icon(Icons.photo);
                          },
                        )
                      : const Icon(Icons.local_pizza_outlined),
                  trailing: Text('\$${wrapper.price}'),
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
