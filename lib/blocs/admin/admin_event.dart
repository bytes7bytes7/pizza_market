part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class AdminLoadEvent extends AdminEvent {
  const AdminLoadEvent();
}

class AdminSaveEvent extends AdminEvent {
  const AdminSaveEvent({required this.wrappers});

  final List<PizzaWrapper> wrappers;

  @override
  List<Object?> get props => [wrappers];
}
