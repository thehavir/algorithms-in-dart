/// Contains binary search method.
class BinarySearch {
  /// Binary search method. Search through a list and finds an item in O(logn).
  /// It returns index of the item if it founds it, otherwise returns -1.
  static int binarySearch({
    required List<int> list,
    required int item,
  }) {
    if (list.isEmpty) {
      throw Exception('List should not be empty');
    }

    int lowLimit = 0;
    int highLimit = list.length - 1;

    while (lowLimit <= highLimit) {
      final int middleItemIndex = (lowLimit + highLimit) ~/ 2;

      final int guess = list[middleItemIndex];

      if (guess == item) {
        return middleItemIndex;
      } else if (guess < item) {
        lowLimit = middleItemIndex + 1;
      } else if (guess > item) {
        highLimit = middleItemIndex - 1;
      }
    }

    return -1;
  }
}
