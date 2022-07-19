class ListMatch<T> {
  final matched = <T>[];
  final unmatched = <T>[];
}

extension SplitMatchExt<T> on List<T> {
  ListMatch<T> splitMatch(bool Function(T element) match) {
    final listMatch = ListMatch<T>();

    for (final element in this) {
      if (match(element)) {
        listMatch.matched.add(element);
      } else {
        listMatch.unmatched.add(element);
      }
    }

    return listMatch;
  }
}
