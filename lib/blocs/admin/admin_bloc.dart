import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repo/pizza_repo.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc(this._pizzaRepo) : super(const AdminInitState()) {
    on<AdminLoadEvent>(_load);
    on<AdminSaveEvent>(_save);
    on<AdminUpdateEvent>(_update);
  }

  final PizzaRepo _pizzaRepo;
  AdminDataState _lastDataState = const AdminDataState([]);
  bool _repoInitialized = false;

  Future<void> _load(AdminLoadEvent event, Emitter<AdminState> emit) async {
    await _initRepo();

    if (state is! AdminLoadingState) {
      emit(const AdminLoadingState());
    }

    try {
      final data = await _pizzaRepo.load();
      final newState = _lastDataState = AdminDataState(data);
      emit(newState);
    } catch (e, s) {
      emit(AdminErrorState(e, s));
    }
  }

  Future<void> _save(AdminSaveEvent event, Emitter<AdminState> emit) async {
    await _initRepo();

    if (state is! AdminLoadingState) {
      emit(const AdminLoadingState());
    }

    final newWrappers = List<PizzaWrapper>.from(event.wrappers);
    for (var i = 0; i < newWrappers.length; i++) {
      final wrapper = newWrappers[i];
      if (wrapper.amount > wrapper.maxAmount) {
        newWrappers[i] = wrapper.copyWith(amount: wrapper.maxAmount);
      }
    }

    await _pizzaRepo.update(newWrappers);

    // reason: get ids
    add(const AdminLoadEvent());
  }

  Future<void> _update(AdminUpdateEvent event, Emitter<AdminState> emit) async {
    final prevState = _lastDataState;

    final newWrappers = List<PizzaWrapper>.from(prevState.wrappers);
    for (final w in event.wrappers) {
      final index = newWrappers.indexWhere((e) => e.id == w.id);

      if (index != -1) {
        final oldWrapper = newWrappers[index];
        newWrappers[index] = oldWrapper.copyWith(
          amount: min(w.amount, oldWrapper.maxAmount),
        );
      }
    }

    final newState = _lastDataState = AdminDataState(newWrappers);

    emit(newState);
  }

  Future<void> _initRepo() async {
    if (!_repoInitialized) {
      await _pizzaRepo.init();
      _repoInitialized = true;
    }
  }
}
