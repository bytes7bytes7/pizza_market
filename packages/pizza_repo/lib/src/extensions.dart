class ListMatch<T> {
  final matched = <T>[];
  final unmatched = <T>[];
}

extension SplitMatchExt<T> on List<T> {
  ListMatch<T> splitMatch(bool Function(T element) matchFunction) {
    final listMatch = ListMatch<T>();

    for (final element in this) {
      if (matchFunction(element)) {
        listMatch.matched.add(element);
      } else {
        listMatch.unmatched.add(element);
      }
    }

    return listMatch;
  }
}
