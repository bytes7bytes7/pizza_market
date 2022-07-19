import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pizza/pizza_bloc.dart';
import '../constants/app.dart' as const_app;
import '../constants/colors.dart' as const_colors;
import '../constants/routes.dart' as const_routes;
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(const_app.appName),
        actions: [
          GradientIconButton(
            icon: const Icon(Icons.shopping_basket),
            onPressed: () {},
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  const_colors.torchRed,
                  const_colors.tickleMePink,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ).createShader(bounds);
            },
          ),
          GradientIconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed(const_routes.admin);
            },
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  const_colors.torchRed,
                  const_colors.tickleMePink,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ).createShader(bounds);
            },
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
                  'Пусто',
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
            return Center(
              child: Column(
                children: [
                  Text('Ошибка'),
                  Text('${state.error}\n\n${state.stackTrace}'),
                  TextButton(
                    child: Text('Попробовать снова'),
                    onPressed: () {
                      _pizzaBloc.add(const PizzaLoadEvent());
                    },
                  )
                ],
              ),
            );
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
