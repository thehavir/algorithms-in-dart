/// Contains sort algorithms.
class Sort {
  /// Implements selection sort algorithm.
  static List<double> selectionSort(List<double> list) {
    final List<double> unsortedList = List<double>.from(list);
    final List<double> sortedList = <double>[];
    double min;

    while (unsortedList.isNotEmpty) {
      min = unsortedList.first;

      for (final double item in unsortedList) {
        if (item < min) {
          min = item;
        }
      }

      sortedList.add(min);
      unsortedList.remove(min);
    }

    return sortedList;
  }

  /// Implements quick sort algorithm.
  static List<double> quickSort(List<double> list) {
    if (list.length < 2) {
      return list;
    }

    final double pivot = list[0];
    final List<double> subList = list.sublist(1);

    final List<double> lessList =
        subList.where((double item) => item <= pivot).toList();
    final List<double> greatList =
        subList.where((double item) => item > pivot).toList();

    return quickSort(lessList) + <double>[pivot] + quickSort(greatList);
  }
}
