import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../admin/admin_bloc.dart';
import '../blocs.dart';

part 'pizza_event.dart';

part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc(this._adminBloc, this._pizzaRepo) : super(const PizzaInitState()) {
    on<PizzaLoadEvent>(_load);
    on<PizzaPickEvent>(_pick);
    on<PizzaUpdateEvent>(_update);
    on<PizzaChangeEvent>(_change);
    on<PizzaOrderEvent>(_order);

    _adminSub = _adminBloc.stream.listen((adminState) {
      if (adminState is AdminDataState) {
        add(PizzaChangeEvent(wrappers: adminState.wrappers));
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

    if (_adminBloc.state is AdminInitState) {
      _adminBloc.add(const AdminLoadEvent());
    }
  }

  Future<void> _pick(PizzaPickEvent event, Emitter<PizzaState> emit) async {
    await _initRepo();

    final wrapper = event.wrapper.copyWith(amount: 1);
    _adminBloc.add(AdminUpdateEvent(wrappers: [wrapper]));

    final prevState = _lastDataState;

    final newWrappers = List<PizzaWrapper>.from(prevState.wrappers);
    final index = newWrappers.indexWhere((e) => e.id == event.wrapper.id);

    if (index != -1) {
      newWrappers[index] = wrapper;

      final newState =
          _lastDataState = PizzaDataState(newWrappers, _cartCost(newWrappers));
      emit(newState);

      unawaited(_pizzaRepo.update([wrapper]));
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
            amount: min(w.amount, w.maxAmount),
          ),
        );
      } else {
        newWrappers.add(w);
      }
    }

    final newState =
        _lastDataState = PizzaDataState(newWrappers, _cartCost(newWrappers));
    emit(newState);
    _adminBloc.add(AdminUpdateEvent(wrappers: newWrappers));

    unawaited(_pizzaRepo.update(newWrappers));
  }

  Future<void> _change(PizzaChangeEvent event, Emitter<PizzaState> emit) async {
    await _initRepo();

    emit(PizzaDataState(event.wrappers, _cartCost(event.wrappers)));
  }

  Future<void> _order(PizzaOrderEvent event, Emitter<PizzaState> emit) async {
    await _initRepo();

    final prevState = _lastDataState;

    final newWrappers = List<PizzaWrapper>.from(prevState.wrappers);
    for (final w in event.wrappers) {
      final index = newWrappers.indexWhere((e) => e.id == w.id);

      if (index != -1) {
        newWrappers.removeAt(index);
      }

      if (w.amount > 0) {
        newWrappers.add(w.copyWith(amount: 0));
      } else {
        newWrappers.add(w);
      }
    }

    final newState = _lastDataState = PizzaDataState(newWrappers, 0);
    emit(newState);
    _adminBloc.add(AdminUpdateEvent(wrappers: newWrappers));

    unawaited(_pizzaRepo.order(newWrappers.toList()));
  }

  Future<void> _initRepo() async {
    if (!_repoInitialized) {
      await _pizzaRepo.init();
      _repoInitialized = true;
    }
  }

  double _cartCost(List<PizzaWrapper> wrappers) => wrappers.fold<double>(
        0.0,
        (prev, curr) =>
            prev + ((curr.amount > 0) ? curr.price * curr.amount : 0),
      );
}
