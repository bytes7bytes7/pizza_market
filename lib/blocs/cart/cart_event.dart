part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartLoadEvent extends CartEvent {
  const CartLoadEvent();
}

class CartPickEvent extends CartEvent {
  const CartPickEvent({required this.pizza});

  final Pizza pizza;

  @override
  List<Object?> get props => [pizza];
}

class CartUpdateEvent extends CartEvent {
  const CartUpdateEvent({required this.wrapper});

  final PizzaWrapper wrapper;

  @override
  List<Object?> get props => [wrapper];
}

class CartOrderEvent extends CartEvent {
  const CartOrderEvent({required this.wrappers});

  final List<PizzaWrapper> wrappers;

  @override
  List<Object?> get props => [wrappers];
}
