part of 'pizza_bloc.dart';

abstract class PizzaEvent extends Equatable {
  const PizzaEvent();

  @override
  List<Object?> get props => [];
}

class PizzaLoadEvent extends PizzaEvent {
  const PizzaLoadEvent();
}

class PizzaPickEvent extends PizzaEvent {
  const PizzaPickEvent({required this.pizza});

  final Pizza pizza;

  @override
  List<Object> get props => [pizza];
}
