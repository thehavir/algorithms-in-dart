/// Uses greedy algorithm to solve covering problem.
class GreedySetCoveringProblem {
  /// Gets a Set of stations (that contain Set of string (that are states))
  /// and the Set of states (strings). It will find a set of stations that
  /// covered all the states using greedy algorithm.
  static Set<Set<String>> findCoveredSet({
    required Map<String, Set<String>> stations,
    required Set<String> states,
  }) {
    final Set<Set<String>> choseStations = <Set<String>>{};
    String bestStation = stations.keys.first;

    while (states.isNotEmpty) {
      for (final String station in stations.keys) {
        /// Intersection of A(a,b,c,d) and B(b,c,y,z) => (b,c)
        final Set<String> bestAndUncoveredIntersection =
            stations[bestStation]!.intersection(states);

        final Set<String> stationAndUncoveredIntersection =
            stations[station]!.intersection(states);

        if (stationAndUncoveredIntersection.length >
            bestAndUncoveredIntersection.length) {
          bestStation = station;
        }
      }

      choseStations.add(stations[bestStation]!);
      states.removeAll(stations[bestStation]!);
    }

    return choseStations;
  }
}
