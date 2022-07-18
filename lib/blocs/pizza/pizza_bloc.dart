import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../admin/admin_bloc.dart';
import '../cart/cart_bloc.dart';

part 'pizza_event.dart';

part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc(this._cartBloc, this._adminBloc) : super(const PizzaInitState()) {
    on<PizzaLoadEvent>(_load);
    on<PizzaPickEvent>(_pick);
  }

  final CartBloc _cartBloc;
  final AdminBloc _adminBloc;

  Future<void> _load(PizzaLoadEvent event, Emitter<PizzaState> emit) async {}

  Future<void> _pick(PizzaPickEvent event, Emitter<PizzaState> emit) async {}
}
