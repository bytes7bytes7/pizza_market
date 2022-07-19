import 'package:db_helper/db_helper.dart';

import 'constants.dart' as pizza_const;
import 'extensions.dart';
import 'pizza_repo.dart';
import 'wrappers/wrappers.dart';

class PizzaRepoImpl implements PizzaRepo {
  const PizzaRepoImpl(this._db);

  final DBHelper _db;

  @override
  Future<void> init() async {
    await _db.createTable(pizza_const.wrapperTable, pizza_const.wrapperFields);
  }

  @override
  Future<List<PizzaWrapper>> load() async {
    final res = await _db.read(pizza_const.wrapperTable);

    return res.map(PizzaWrapper.fromJson).toList();
  }

  @override
  Future<void> pick(PizzaWrapper wrapper) async {
    final newWrapper = wrapper.copyWith(amount: 1);
    return _db.update(pizza_const.wrapperTable, [newWrapper.toJson()]);
  }

  @override
  Future<void> update(List<PizzaWrapper> wrappers) async {
    final res = await _db.read(pizza_const.wrapperTable);
    final resIds = res.map((e) => e[pizza_const.id]);

    final match = wrappers.splitMatch((e) => resIds.contains(e.id));

    final oldWrappers = match.matched;
    final newWrappers = match.unmatched;

    final oldWhere = oldWrappers.map((e) => {pizza_const.id: e.id}).toList();
    await _db.update(
      pizza_const.wrapperTable,
      oldWrappers.map((e) => e.toJson()).toList(),
      where: oldWhere,
    );

    await _db.add(
      pizza_const.wrapperTable,
      newWrappers.map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future<void> order(List<PizzaWrapper> wrappers) async {
    final newWrappers = wrappers.map((e) => e.copyWith(amount: 0));
    return _db.update(
      pizza_const.wrapperTable,
      newWrappers.map((e) => e.toJson()).toList(),
    );
  }
}
