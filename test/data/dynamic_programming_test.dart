import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:algorithms_in_dart/data/algorithm_euclidean.dart';
import 'package:algorithms_in_dart/data/dynamic_programming.dart';

void main() {
  group('Test LongestSubsequence class', () {
    const String first = 'havirh';
    const String second = 'hani';

    final List<String> firstList = List<String>.generate(
      first.length,
      (int index) => first.split('')[index],
    );
    final List<String> secondList = List<String>.generate(
      second.length,
      (int index) => second.split('')[index],
    );

    test('Test String manipulation - pre implementation algorithm', () {
      expect(firstList[2], 'v');

      final List<String> f = List<String>.generate(
          first.length, (int index) => first.split('')[index]);
      expect(f[2], 'v');
    });

    // Using two loop and simply stash each character when they are the same.
    // This approach is work for specific inputs and doesn't work always.
    //
    // For example:
    // a = 'haiha', b = 'hani'
    // Expected LCS (Longest Common Subsequence) = 'hai'
    // but result is: 'haiha'
    test('Test wrong approach', () {
      final StringBuffer result = StringBuffer();

      for (final String characterOfFirstList in firstList) {
        for (final String characterOfSecondList in secondList) {
          if (characterOfFirstList == characterOfSecondList) {
            result.write(characterOfSecondList);
          }
        }
      }

      expect('haih', result.toString());
    });

    test('Test dynamic programming approach - implementation', () {
      final List<List<int>> tableResult =
          generateLCSTable(firstList, secondList);

      print(tableResult.toString());
      expect(3, tableResult[firstList.length][secondList.length]);
    });

    test('Test reading the value of LCS', () {
      final List<List<int>> tableResult =
          generateLCSTable(firstList, secondList);

      final StringBuffer lcsResult = StringBuffer();
      int i = firstList.length, j = secondList.length;

      while (i > 0 && j > 0) {
        if (firstList[i - 1] == secondList[j - 1]) {
          lcsResult.write(firstList[i - 1]);

          i--;
          j--;
        } else if (tableResult[i - 1][j] > tableResult[i][j - 1]) {
          i--;
        } else {
          j--;
        }
      }

      final String lcs = lcsResult.toString().split('').reversed.join();

      expect(lcs, 'hai');
    });

    test('Test findLongestSubsequence function from Dynamic class', () {
      final String subsequence =
          Dynamic.findLongestSubsequence('havir', 'hani');

      expect(subsequence, 'hai');

      final String genome =
          Dynamic.findLongestSubsequence('GTTCCTAATA', 'CGATAATTGAGA');

      expect(genome, 'CTAATA');
    });
  });

  group('Test Knapsack problem', () {
    final List<String> items = <String>['Guitar', 'Stereo', 'Laptop'];
    final Map<String, int> costs = <String, int>{
      'Guitar': 1500,
      'Stereo': 3000,
      'Laptop': 2000,
    };
    final Map<String, int> weights = <String, int>{
      'Guitar': 1,
      'Stereo': 4,
      'Laptop': 3,
    };

    test('Test knapsack problem implementation', () {
      final int maximum = weights.values.reduce(max);
      final int minimum = weights.values.reduce(min);

      final List<List<int>> tableResult = List<List<int>>.generate(
        items.length + 1,
        (_) => List<int>.generate(maximum + 1, (_) => 0),
      );

      final int gcd =
          EuclideanAlgorithm.findGCD(dividend: maximum, divisor: minimum);

      for (int i = 1; i <= items.length; i++) {
        for (int j = minimum; j <= maximum; j += gcd) {
          int currentMax = 0;
          final int previousMax = tableResult[i - 1][j];

          // We have to start i at 1 because tableResult has one row and one
          // column more to stash 0 for next manipulation. So the current item
          // index will be `i - 1`.
          final int currentItemIndex = i - 1;
          final int itemWeight = weights[items[currentItemIndex]]!;
          final int itemCost = costs[items[currentItemIndex]]!;

          if (itemWeight <= j) {
            currentMax = itemCost + tableResult[i - 1][j - itemWeight];
          }

          tableResult[i][j] = max(previousMax, currentMax);
        }
      }

      print(tableResult.toString());
      expect(tableResult[items.length][maximum], 3500);
    });

    test('Test Knapsack function from Dynamic class', () {
      final int resultCost = Dynamic.knapsack(4, costs, weights);

      expect(resultCost, 3500);
    });

    test('Test Knapsack function from Dynamic class - with iPhone!', () {
      final Map<String, int> newCosts = <String, int>{
        'Guitar': 1500,
        'Stereo': 3000,
        'Laptop': 2000,
        'iPhone': 2000,
      };
      final Map<String, int> newWeights = <String, int>{
        'Guitar': 1,
        'Stereo': 4,
        'Laptop': 3,
        'iPhone': 1,
      };
      final int resultCost = Dynamic.knapsack(4, newCosts, newWeights);

      expect(resultCost, 4000);
    });
  });
}

List<List<int>> generateLCSTable(
  List<String> firstList,
  List<String> secondList,
) {
  /*final List<List<int>> tableResult = <List<int>>[
        <int>[0, 0, 0, 0, 0],
        <int>[0, 0, 0, 0, 0],
        <int>[0, 0, 0, 0, 0],
        <int>[0, 0, 0, 0, 0],
        <int>[0, 0, 0, 0, 0],
        <int>[0, 0, 0, 0, 0],
        <int>[0, 0, 0, 0, 0],
      ];*/

  // Create and fill the table (instead of doing above).
  final List<List<int>> tableResult = List<List<int>>.generate(
    firstList.length + 1,
    (_) => List<int>.generate(
      secondList.length + 1,
      (_) => 0,
    ),
  );

  for (int i = 0; i <= firstList.length; i++) {
    for (int j = 0; j <= secondList.length; j++) {
      if (i == 0 || j == 0) {
        // Because we calculate i-1 and j-1, so if we don't do this, we will
        // get exception. The result will be correct because we iterate
        // until i <= firstList.length instead of i < firstList.length (also
        // same for j).
        tableResult[i][j] = 0;
      } else if (firstList[i - 1] == secondList[j - 1]) {
        tableResult[i][j] = tableResult[i - 1][j - 1] + 1;
      } else {
        tableResult[i][j] = max(tableResult[i - 1][j], tableResult[i][j - 1]);
      }
    }
  }
  return tableResult;
}
