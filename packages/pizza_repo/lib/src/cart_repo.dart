import 'wrappers/wrappers.dart';

abstract class CartRepo {
  const CartRepo();

  Future<List<PizzaWrapper>> load();

  Future<void> pick(PizzaWrapper wrapper);

  Future<void> update(List<PizzaWrapper> wrappers);

  Future<void> order(List<PizzaWrapper> wrappers);
}
