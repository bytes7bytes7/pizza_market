import 'wrappers/wrappers.dart';

abstract class AdminRepo {
  const AdminRepo();

  Future<List<PizzaWrapper>> load();

  Future<void> save(List<PizzaWrapper> wrappers);
}
