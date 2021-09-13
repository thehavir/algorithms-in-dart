import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:algorithms_in_dart/data/k_nearest_neighbors.dart';

void main() {
  group('Test k-nearest neighbors', () {
    group('Test classification', () {
      final List<int> havirRatings = <int>[3, 4, 4, 1, 4];
      final List<int> haniRatings = <int>[4, 3, 5, 1, 5];

      test('Test k-nearest implementation', () {
        double sum = 0;
        for (int i = 0; i < havirRatings.length; i++) {
          sum += pow(havirRatings[i] - haniRatings[i], 2);
        }

        final double distanceHavirAndHani = sqrt(sum);

        expect(distanceHavirAndHani, 2);
      });

      test('Test distance function from KNearest class', () {
        final double distanceHavirAndHani =
            KNearest.distance(havirRatings, haniRatings);

        expect(distanceHavirAndHani, 2);
      });
    });

    group('Test regression implementation', () {
      final Map<List<int>, int> a = <List<int>, int>{
        <int>[5, 1, 0]: 300
      };
      final Map<List<int>, int> b = <List<int>, int>{
        <int>[3, 1, 1]: 225
      };
      final Map<List<int>, int> c = <List<int>, int>{
        <int>[1, 1, 0]: 75
      };
      final Map<List<int>, int> d = <List<int>, int>{
        <int>[4, 0, 1]: 200
      };
      final Map<List<int>, int> e = <List<int>, int>{
        <int>[4, 0, 0]: 150
      };
      final Map<List<int>, int> f = <List<int>, int>{
        <int>[2, 0, 0]: 50
      };

      final List<Map<List<int>, int>> params = <Map<List<int>, int>>[
        a,
        b,
        c,
        d,
        e,
        f
      ];

      final List<int> today = <int>[4, 1, 0];

      test('Test regression function implementation', () {
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

        expect(prediction, 218.75);
      });

      test('Test regression function from KNearest class', () {
        final double prediction =
            KNearest.prediction(<Map<List<int>, int>>[a, b, c, d, e, f], today);

        expect(prediction, 218.75);
      });
    });
  });
}
