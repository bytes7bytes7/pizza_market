import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pizza_repo/pizza_repo.dart';

class CartNotifier extends ChangeNotifier {
  final List<PizzaWrapper> _wrappers = [];

  UnmodifiableListView<PizzaWrapper> get wrappers =>
      UnmodifiableListView(_wrappers);

  double get totalCost {
    var result = 0.0;
    for (final e in _wrappers) {
      if (e.amount > 0) {
        result += e.price * e.amount;
      }
    }

    return result;
  }

  void add(PizzaWrapper wrapper) {
    _wrappers.add(wrapper);

    notifyListeners();
  }

  void update(PizzaWrapper oldWrapper, PizzaWrapper newWrapper) {
    final index = _wrappers.indexOf(oldWrapper);

    if (index != -1) {
      _wrappers[index] = newWrapper;

      notifyListeners();
    }
  }

  void removeAll() {
    _wrappers.clear();

    notifyListeners();
  }
}
