part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

class AdminInitState extends AdminState {
  const AdminInitState();
}

class AdminLoadingState extends AdminState {
  const AdminLoadingState();
}

class AdminDataState extends AdminState {
  const AdminDataState(this.wrappers);

  final List<PizzaWrapper> wrappers;

  @override
  List<Object?> get props => [wrappers];
}
