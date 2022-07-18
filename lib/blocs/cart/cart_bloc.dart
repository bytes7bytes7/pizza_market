import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repo/pizza_repo.dart';

import '../admin/admin_bloc.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._adminBloc, this._cartRepo) : super(const CartInitState()) {
    on<CartLoadEvent>(_load);
    on<CartPickEvent>(_pick);
    on<CartUpdateEvent>(_update);
    on<CartOrderEvent>(_order);
  }

  final AdminBloc _adminBloc;
  final CartRepo _cartRepo;

  Future<void> _load(CartLoadEvent event, Emitter<CartState> emit) async {}

  Future<void> _pick(CartPickEvent event, Emitter<CartState> emit) async {}

  Future<void> _update(CartUpdateEvent event, Emitter<CartState> emit) async {}

  Future<void> _order(CartOrderEvent event, Emitter<CartState> emit) async {}
}
