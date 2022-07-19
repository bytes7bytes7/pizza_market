import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onPressed: () {},
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

                  if (wrappers.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.empty,
                        style: theme.textTheme.headline6,
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
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
