import 'wrappers/wrappers.dart';

abstract class PizzaRepo {
  const PizzaRepo();

  Future<void> init();

  Future<List<PizzaWrapper>> load();

  Future<void> pick(PizzaWrapper wrapper);

  Future<void> update(List<PizzaWrapper> wrappers);

  Future<void> order(List<PizzaWrapper> wrappers);
}
