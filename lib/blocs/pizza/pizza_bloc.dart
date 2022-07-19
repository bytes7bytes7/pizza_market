import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../admin/admin_bloc.dart';

part 'pizza_event.dart';

part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc(this._adminBloc, this._pizzaRepo) : super(const PizzaInitState()) {
    on<PizzaLoadEvent>(_load);
    on<PizzaPickEvent>(_pick);
    on<PizzaUpdateEvent>(_update);
    on<PizzaOrderEvent>(_order);

    _adminSub = _adminBloc.stream.listen((adminState) {
      if (adminState is AdminDataState) {
        add(PizzaUpdateEvent(wrappers: adminState.wrappers));
      }
    });
  }

  final AdminBloc _adminBloc;
  final PizzaRepo _pizzaRepo;
  bool _repoInitialized = false;
  late final StreamSubscription _adminSub;
  PizzaDataState _lastDataState = const PizzaDataState([], 0);

  @override
  Future<void> close() async {
    await _adminSub.cancel();

    await super.close();
  }

  Future<void> _load(PizzaLoadEvent event, Emitter<PizzaState> emit) async {
    await _initRepo();

    if (state is! PizzaLoadingState) {
      emit(const PizzaLoadingState());
    }

    final data = await _pizzaRepo.load();

    final newState = _lastDataState = PizzaDataState(data, _cartCost(data));
    emit(newState);
  }

  Future<void> _pick(PizzaPickEvent event, Emitter<PizzaState> emit) async {
    await _initRepo();

    final wrapper = event.wrapper.copyWith(amount: 1);
    final prevState = _lastDataState;

    final newWrappers = List<PizzaWrapper>.from(prevState.wrappers);
    final index = newWrappers.indexWhere((e) => e.id == event.wrapper.id);

    if (index != -1) {
      newWrappers[index] = wrapper;

      final newState =
          _lastDataState = PizzaDataState(newWrappers, _cartCost(newWrappers));
      emit(newState);

      unawaited(_pizzaRepo.pick(wrapper));
    }
  }

  Future<void> _update(PizzaUpdateEvent event, Emitter<PizzaState> emit) async {
    await _initRepo();

    final prevState = _lastDataState;

    final oldWrappers = prevState.wrappers;
    final newWrappers = <PizzaWrapper>[];

    for (final w in event.wrappers) {
      final index = oldWrappers.indexWhere((e) => e.id == w.id);

      if (index != -1) {
        newWrappers.add(
          w.copyWith(
            amount: min(oldWrappers[index].amount, w.maxAmount),
          ),
        );
      } else {
        newWrappers.add(w);
      }
    }

    final newState =
        _lastDataState = PizzaDataState(newWrappers, _cartCost(newWrappers));
    emit(newState);

    unawaited(_pizzaRepo.update(newWrappers));
  }

  Future<void> _order(PizzaOrderEvent event, Emitter<PizzaState> emit) async {
    await _initRepo();

    final prevState = _lastDataState;

    final order = prevState.wrappers.where((e) => e.amount > 0);

    final newWrappers = <PizzaWrapper>[];
    for (var w in prevState.wrappers) {
      if (w.amount > 0) {
        newWrappers.add(w.copyWith(amount: 0));
      } else {
        newWrappers.add(w);
      }
    }

    final newState = _lastDataState = PizzaDataState(newWrappers, 0);
    emit(newState);

    unawaited(_pizzaRepo.order(order.toList()));
  }

  Future<void> _initRepo()async {
    if (!_repoInitialized) {
      await _pizzaRepo.init();
      _repoInitialized = true;
    }
  }

  double _cartCost(List<PizzaWrapper> wrappers) => wrappers.fold<double>(
        0.0,
        (prev, curr) => prev + ((curr.amount > 0) ? curr.price : 0),
      );
}
