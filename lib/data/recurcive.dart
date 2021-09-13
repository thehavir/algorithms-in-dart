/// Functions are implemented in this class using recursive way.
class Recursive {
  /// Calculates sum of the items in the `list`.
  static int sumListItems({required List<int> list, int sum = 0}) {
    if (list.isEmpty) {
      return sum;
    }

    return sumListItems(
      list: list.sublist(0, list.length - 1),
      sum: sum + list.last,
    );
  }

  /// Calculates sum of the items in the `list` based on Grokking Algorithm
  /// book.
  static int sumListItemsAditya(List<int> list) {
    if (list.isEmpty) {
      return 0;
    }

    return list[0] + sumListItemsAditya(list.sublist(1));
  }

  /// Counts items in the `list`.
  static int countListItems(List<int> list) {
    if (list.isEmpty) {
      return 0;
    }

    return 1 + countListItems(list.sublist(1));
  }

  /// Finds the maximum item in the `list`.
  static int findMax({required List<int> list, int max = 0}) {
    if (list.isEmpty) {
      return max;
    }

    if (max < list.last) {
      max = list.last;
    }

    return findMax(list: list.sublist(0, list.length - 1), max: max);
  }

  /// Finds the maximum item in the `list` based on Grokking Algorithm book.
  static int findMaxAditya(List<int> list) {
    if (list.length == 2) {
      if (list[0] > list[1]) {
        return list[0];
      }

      return list[1];
    }

    final int subMax = findMaxAditya(list.sublist(1));

    if (list[0] > subMax) {
      return list[0];
    }

    return subMax;
  }
}
