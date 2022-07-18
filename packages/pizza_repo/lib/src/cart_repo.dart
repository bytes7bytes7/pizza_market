import 'wrappers/wrappers.dart';

abstract class CartRepo {
  const CartRepo();

  Future<List<PizzaWrapper>> load();

  Future<void> pick(PizzaWrapper wrapper);

  Future<void> update(PizzaWrapper wrapper);

  Future<void> order(List<PizzaWrapper> wrappers);
}
