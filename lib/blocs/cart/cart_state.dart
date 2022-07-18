part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitState extends CartState {
  const CartInitState();
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartDateState extends CartState {
  const CartDateState({required this.wrappers, required this.totalPrice});

  final List<PizzaWrapper> wrappers;
  final double totalPrice;

  @override
  List<Object?> get props => [wrappers, totalPrice];
}
