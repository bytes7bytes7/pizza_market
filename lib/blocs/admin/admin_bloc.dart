import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repo/pizza_repo.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc(this._pizzaRepo) : super(const AdminInitState()) {
    on<AdminLoadEvent>(_load);
    on<AdminSaveEvent>(_save);
  }

  final PizzaRepo _pizzaRepo;
  bool _repoInitialized = false;

  Future<void> _load(AdminLoadEvent event, Emitter<AdminState> emit) async {
    await _initRepo();

    if (state is! AdminLoadingState) {
      emit(const AdminLoadingState());
    }

    try {
      final data = await _pizzaRepo.load();
      emit(AdminDataState(data));
    } catch (e, s) {
      emit(AdminErrorState(e, s));
    }
  }

  Future<void> _save(AdminSaveEvent event, Emitter<AdminState> emit) async {
    await _initRepo();

    emit(AdminDataState(event.wrappers));

    await _pizzaRepo.update(event.wrappers);
  }

  Future<void> _initRepo()async {
    if (!_repoInitialized) {
      await _pizzaRepo.init();
      _repoInitialized = true;
    }
  }
}
