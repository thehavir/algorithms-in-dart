/// Includes functions that uses euclidean algorithm.
class EuclideanAlgorithm {
  /// find Greatest Common Divisor (GCD) using Euclidean Algorithm.
  ///
  /// The Euclidean Algorithm for finding GCD(A,B) is as follows:
  ///  - If A = 0 then GCD(A,B)=B, since the GCD(0,B)=B, and we can stop.
  ///  - If B = 0 then GCD(A,B)=A, since the GCD(A,0)=A, and we can stop.
  ///  - Write A in quotient remainder form (A = B⋅Q + R)
  ///  - Find GCD(B,R) using the Euclidean Algorithm since GCD(A,B) = GCD(B,R)
  ///
  /// Terminology:
  /// A -> dividend
  /// B-> divisor
  /// Q-> quotient
  /// R-> remainder
  static int findGCD({
    required int dividend,
    required int divisor,
    bool debug = false,
  }) {
    if (divisor == 0) {
      return dividend;
    } else if (dividend == 0) {
      return divisor;
    }

    final int quotient = dividend ~/ divisor;
    final int remainder = (dividend % divisor).toInt();

    if (debug) {
      print('GCD result ------');
      print('dividend: $dividend');
      print('divisor: $divisor');
      print('quotient: $quotient');
      print('end------');
    }

    return findGCD(dividend: divisor, divisor: remainder);
  }
}
