import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:algorithms_in_dart/data/greedy_set_covering_problem.dart';

void main() {
  test('Test solving set-covering problem using greedy algorithm', () {
    final Map<String, Set<String>> stations = <String, Set<String>>{};

    stations['kEight'] = <String>{'JY'};
    stations['kFive'] = <String>{'CA', 'WA'};
    stations['kThree'] = <String>{'OR', 'NV', 'CA'};
    stations['kSix'] = <String>{'MT', 'OR'};
    stations['kFour'] = <String>{'NV', 'UT'};
    stations['kSeven'] = <String>{'JY', 'UT', 'NV'};
    stations['kTwo'] = <String>{'WA', 'ID', 'MT'};
    stations['kOne'] = <String>{'ID', 'NV', 'UT'};

    final Set<String> statesName = <String>{
      'ID',
      'NV',
      'UT',
      'WA',
      'MT',
      'OR',
      'CA',
      'JY',
    };

    final Set<Set<String>> coveredSet = GreedySetCoveringProblem.findCoveredSet(
        stations: stations, states: statesName);

    final Set<Set<String>> expectedList = <Set<String>>{
      stations['kTwo']!,
      stations['kThree']!,
      stations['kSeven']!,
    };

    expect(coveredSet, expectedList);

    // Using equality
    final Function listEquality =
        const DeepCollectionEquality.unordered().equals;

    expect(listEquality(coveredSet, expectedList), true);
  });
}
