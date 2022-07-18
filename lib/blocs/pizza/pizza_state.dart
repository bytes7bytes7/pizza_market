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
  const PizzaDataState(this.pizzas);

  final List<Pizza> pizzas;

  @override
  List<Object> get props => [pizzas];
}
