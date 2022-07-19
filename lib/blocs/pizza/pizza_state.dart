part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object?> get props => [];
}

class PizzaInitState extends PizzaState {
  const PizzaInitState();
}

class PizzaLoadingState extends PizzaState {
  const PizzaLoadingState();
}

class PizzaDataState extends PizzaState {
  const PizzaDataState(this.wrappers, this.cartCost);

  final List<PizzaWrapper> wrappers;
  final double cartCost;

  @override
  List<Object> get props => [wrappers, cartCost];
}

class PizzaErrorState extends PizzaState {
  const PizzaErrorState(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}
