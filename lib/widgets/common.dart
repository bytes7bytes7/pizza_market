String beautifyCost(double cost) {
  if (cost == cost.toInt()) {
    return '${cost.toInt()}';
  }

  return cost.toStringAsFixed(2);
}
