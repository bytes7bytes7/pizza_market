import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../blocs/blocs.dart';
import '../l10n/l10n.dart';
import '../widgets/widgets.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late final ScrollController _scrollController;
  late final AdminBloc _adminBloc;
  final _items = <PizzaWrapper>[];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _adminBloc = context.read<AdminBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: DefaultAppBar(
        title: l10n.addPizza,
        action: PrimaryButton(
          icon: Icons.add,
          onPressed: () {
            setState(() {
              _items.add(
                const PizzaWrapper(
                  title: '',
                  price: 0,
                  imageUrl: '',
                  amount: 0,
                  maxAmount: 1,
                ),
              );
              Future.delayed(const Duration(milliseconds: 300), () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              });
            });
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminInitState) {
                  _adminBloc.add(const AdminLoadEvent());
                }

                if (state is AdminDataState) {
                  final wrappers = state.wrappers;

                  if (wrappers.isEmpty && _items.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.empty,
                        style: theme.textTheme.headline6,
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: wrappers.length + _items.length,
                    itemExtent: pizzaSettingCardExtent,
                    itemBuilder: (context, index) {
                      if (index < wrappers.length) {
                        return PizzaSettingCard(
                          wrapper: wrappers[index],
                        );
                      }

                      return PizzaSettingCard(
                        wrapper: _items[index - wrappers.length],
                      );
                    },
                  );
                } else if (state is AdminErrorState) {
                  return ErrorLabel(
                    error: state.error,
                    stackTrace: state.stackTrace,
                    buttonText: l10n.tryAgain,
                    onPressed: () {
                      _adminBloc.add(const AdminLoadEvent());
                    },
                  );
                }

                return const LoadingWidget();
              },
            ),
          ),
          FractionallySizedBox(
            widthFactor: 1,
            child: BigButton(
              child: Text(
                l10n.save,
                style: theme.textTheme.button?.copyWith(
                  color: theme.scaffoldBackgroundColor,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
