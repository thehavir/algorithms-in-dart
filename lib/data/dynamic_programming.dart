import 'dart:math';

import 'package:algorithms_in_dart/data/algorithm_euclidean.dart';

/// Includes functions that are implemented using dynamic programming.
class Dynamic {
  /// Finds the longest subsequence of two strings.
  ///
  /// Longest subsequence of `havir` and `hani` is `hai`.
  static String findLongestSubsequence(String first, String second) {
    // Turn strings to lists.
    final List<String> firstList = List<String>.generate(
        first.length, (int index) => first.split('')[index]);
    final List<String> secondList = List<String>.generate(
        second.length, (int index) => second.split('')[index]);

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

    // Reading the value of LCS from lcs table that we've just created
    // (tableResult).
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

    // Reverse the string as it's calculated reversely.
    final String lcs = lcsResult.toString().split('').reversed.join();

    return lcs;
  }

  /// Solves Knapsack problem using dynamic programming.
  /// It gets a hashtable of item's costs and weights and return the maximum
  /// cost that can feel in the knapsack.
  static int knapsack(
    int knapsackWeight,
    Map<String, int> costs,
    Map<String, int> weights,
  ) {
    final List<String> items = costs.keys.toList();

    final int maximum = knapsackWeight;
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

    return tableResult[items.length][maximum];
  }
}
