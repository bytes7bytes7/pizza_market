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

  Future<void> _load(AdminLoadEvent event, Emitter<AdminState> emit) async {}

  Future<void> _save(AdminSaveEvent event, Emitter<AdminState> emit) async {}
}
