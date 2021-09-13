import 'dart:math';

/// Includes function related to k-nearest neighbors algorithm.
class KNearest {
  /// Finds distance of two item.
  static double distance(List<int> firstItem, List<int> secondItem) {
    double sum = 0;

    for (int i = 0; i < firstItem.length; i++) {
      sum += pow(firstItem[i] - secondItem[i], 2);
    }

    final double distance = sqrt(sum);

    return distance;
  }

  /// Regression - Predicts value for `today` based on neighbors value.
  static double prediction(List<Map<List<int>, int>> params, List<int> today) {
    final Map<Map<List<int>, int>, double> distances =
        <Map<List<int>, int>, double>{};
    final List<int> values = <int>[];

    // Calculate each distance
    for (int i = 0; i < params.length; i++) {
      distances[params[i]] = KNearest.distance(params[i].keys.first, today);
    }

    // Sort distances map based on its values.
    final List<Map<List<int>, int>> sortedKeys = distances.keys
        .toList(growable: false)
          ..sort((Map<List<int>, int> k1, Map<List<int>, int> k2) =>
              distances[k1]!.compareTo(distances[k2]!));
    final Map<Map<List<int>, int>, double> sortedDistances =
        Map<Map<List<int>, int>, double>.fromIterable(sortedKeys,
            key: (dynamic k) => k, value: (dynamic k) => distances[k]!);

    // 3 is the K in k-nearest neighbors algorithm. The number of neighbors
    // that we should check.
    for (int i = 0; i <= 3; i++) {
      values.add(sortedDistances.keys.toList()[i].values.first);
    }

    // Average of the values of neighbors.
    final double prediction =
        values.reduce((int a, int b) => a + b) / values.length;

    return prediction;
  }
}
