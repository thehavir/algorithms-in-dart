import 'package:flutter_test/flutter_test.dart';
import 'package:algorithms_in_dart/data/search_binary.dart';

void main() {
  group('Test Binary Search', () {
    const List<int> mockSortedList = <int>[
      5,
      9,
      11,
      17,
      19,
      21,
      22,
      23,
      45,
      51,
      84,
      99,
      103,
      123,
      143,
      144,
    ];

    test('Test binary search function in BinarySearch class', () {
      final int indexOf123 =
          BinarySearch.binarySearch(list: mockSortedList, item: 103);

      expect(12, indexOf123);
      expect(103, mockSortedList[indexOf123]);
    });
  });
}
