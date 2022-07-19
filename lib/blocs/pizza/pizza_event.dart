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
  const PizzaPickEvent({required this.wrapper});

  final PizzaWrapper wrapper;

  @override
  List<Object> get props => [wrapper];
}

// amount update
class PizzaUpdateEvent extends PizzaEvent {
  const PizzaUpdateEvent({required this.wrappers});

  final List<PizzaWrapper> wrappers;

  @override
  List<Object> get props => [wrappers];
}

// admin changes
class PizzaChangeEvent extends PizzaEvent {
  const PizzaChangeEvent({required this.wrappers});

  final List<PizzaWrapper> wrappers;

  @override
  List<Object> get props => [wrappers];
}

class PizzaOrderEvent extends PizzaEvent {
  const PizzaOrderEvent({required this.wrappers});

  final List<PizzaWrapper> wrappers;

  @override
  List<Object> get props => [wrappers];
}
