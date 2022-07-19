import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../constants/measures.dart' as const_measures;
import '../blocs/blocs.dart';
import '../l10n/l10n.dart';
import '../widgets/widgets.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late final AdminBloc _adminBloc;

  @override
  void initState() {
    super.initState();

    _adminBloc = context.read<AdminBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.addPizza,
        action: PrimaryButton(
          icon: Icons.add,
          onPressed: () {
            _adminBloc.add(
              AdminSaveEvent(
                wrappers: [
                  PizzaWrapper(
                    title: 'title3',
                    price: 10,
                    imageUrl:
                        'https://staticy.dominospizza.ru/api/medium/ProductOsg/Web/CHITER/NULL/NULL/RU',
                    amount: 0,
                    maxAmount: 1,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminInitState) {
            _adminBloc.add(const AdminLoadEvent());
          }

          if (state is AdminDataState) {
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
                return PizzaSettingCard(
                  wrapper: wrappers[index],
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
    );
  }
}
