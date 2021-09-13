import 'package:flutter_test/flutter_test.dart';
import 'package:algorithms_in_dart/data/sort.dart';

void main() {
  const List<double> mockUnsortedList = <double>[
    84,
    19,
    144,
    21,
    51,
    103,
    5,
  ];
  const List<double> mockSortedList = <double>[
    5,
    19,
    21,
    51,
    84,
    103,
    144,
  ];

  group('Test Sort algorithms', () {
    test('Test selection sort function from Sort class', () {
      final List<double> sortedList = Sort.selectionSort(mockUnsortedList);

      expect(sortedList, mockSortedList);
    });

    test('Test quick sort function from Sort class', () {
      final List<double> sortedList = Sort.quickSort(mockUnsortedList);

      expect(sortedList, mockSortedList);
    });
  });
}
