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
  late final ValueNotifier<Map<int, bool>> _validNotifier;
  late final AdminBloc _adminBloc;
  final _newItems = <PizzaWrapper>[];
  final _needUpdate = <PizzaWrapper>[];

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _validNotifier = ValueNotifier(<int, bool>{});
    _adminBloc = context.read<AdminBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _validNotifier.dispose();

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
              _newItems.add(
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

                  if (wrappers.isEmpty && _newItems.isEmpty) {
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
                    itemCount: wrappers.length + _newItems.length,
                    itemExtent: pizzaSettingCardExtent,
                    itemBuilder: (context, index) {
                      if (index < wrappers.length) {
                        return PizzaSettingCard(
                          onValidChanged: (value, [wrapper]) =>
                              _onValidChanged(index, value, wrapper),
                          wrapper: wrappers[index],
                        );
                      }

                      return PizzaSettingCard(
                        onValidChanged: (value, [wrapper]) =>
                            _onValidChanged(index, value, wrapper),
                        wrapper: _newItems[index - wrappers.length],
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
            child: ValueListenableBuilder<Map<int, bool>>(
              valueListenable: _validNotifier,
              child: Text(
                l10n.save,
                style: theme.textTheme.button?.copyWith(
                  color: theme.scaffoldBackgroundColor,
                ),
                textAlign: TextAlign.center,
              ),
              builder: (context, value, child) {
                final allValid =
                    value.entries.every((p) => p.value) && value.isNotEmpty;

                return BigButton(
                  onPressed: allValid
                      ? () {
                          _adminBloc.add(
                            AdminSaveEvent(
                              wrappers: List.from(_needUpdate),
                            ),
                          );
                          _needUpdate.clear();
                          _newItems.clear();
                        }
                      : null,
                  child: child ?? const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onValidChanged(int index, bool isValid, PizzaWrapper? wrapper) {
    if (wrapper != null) {
      final oldIndex = _needUpdate.indexWhere((e) => e.id == wrapper.id);

      if (oldIndex != -1) {
        _needUpdate[oldIndex] = wrapper;
      } else {
        _needUpdate.add(wrapper);
      }
    }

    final map = Map<int, bool>.from(_validNotifier.value);
    map[index] = isValid;
    _validNotifier.value = map;
  }
}
