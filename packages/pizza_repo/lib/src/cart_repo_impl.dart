import 'package:db_helper/db_helper.dart';

import 'cart_repo.dart';
import 'constants.dart' as pizza_const;
import 'wrappers/wrappers.dart';

class CartRepoImpl implements CartRepo {
  const CartRepoImpl(this._db);

  final DBHelper _db;

  @override
  Future<List<PizzaWrapper>> load() async {
    final res = await _db.read(pizza_const.cartTable);

    return res.map(PizzaWrapper.fromJson).toList();
  }

  @override
  Future<void> pick(PizzaWrapper wrapper) async {
    return _db.add(pizza_const.cartTable, [wrapper.toJson()]);
  }

  @override
  Future<void> update(List<PizzaWrapper> wrappers) async {
    return _db.update(
      pizza_const.cartTable,
      wrappers.map((e) => e.toJson()).toList(),
      where: wrappers.map((e) => {pizza_const.id: e.id}).toList(),
    );
  }

  @override
  Future<void> order(List<PizzaWrapper> wrappers) async {
    return _db.delete(pizza_const.cartTable);
  }
}
