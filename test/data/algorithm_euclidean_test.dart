import 'package:flutter_test/flutter_test.dart';
import 'package:algorithms_in_dart/data/algorithm_euclidean.dart';

void main() {
  group('Test euclidean algorithm', () {
    test('Test find GCD', () {
      const int numberOne = 455;
      const int numberTwo = 74854;

      final int gcd =
          EuclideanAlgorithm.findGCD(dividend: numberOne, divisor: numberTwo);

      expect(gcd, 13);
    });
  });
}
