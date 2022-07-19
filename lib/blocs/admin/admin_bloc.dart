import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repo/pizza_repo.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc(this._adminRepo) : super(const AdminInitState()) {
    on<AdminLoadEvent>(_load);
    on<AdminSaveEvent>(_save);
  }

  final AdminRepo _adminRepo;

  Future<void> _load(AdminLoadEvent event, Emitter<AdminState> emit) async {
    if (state is! AdminLoadingState) {
      emit(const AdminLoadingState());
    }

    try {
      final data = await _adminRepo.load();
      emit(AdminDataState(data));
    } catch (e, s) {
      emit(AdminErrorState(e, s));
    }
  }

  Future<void> _save(AdminSaveEvent event, Emitter<AdminState> emit) async {
    emit(AdminDataState(event.wrappers));

    await _adminRepo.save(event.wrappers);
  }
}
