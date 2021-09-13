import 'package:flutter_test/flutter_test.dart';
import 'package:algorithms_in_dart/data/dijkstra.dart';

void main() {
  group('Test dijkstra algorithm', () {
    final Node piano = Node('Piano');
    final Node drums = Node('Drums')..children = <Node, double>{piano: 10};
    final Node guitar = Node('Guitar')..children = <Node, double>{piano: 20};
    final Node poster = Node('Poster')
      ..children = <Node, double>{guitar: 30, drums: 35};
    final Node lp = Node('LP')
      ..children = <Node, double>{guitar: 15, drums: 20};
    final Node book = Node('Book')..children = <Node, double>{poster: 0, lp: 5};

    test('First table is correct', () {
      final Map<Node, Node> parents = <Node, Node>{};
      final Map<Node, double> costs = <Node, double>{};

      book.children.forEach((Node node, double cost) {
        costs[node] = cost;
        parents[node] = book;
      });

      expect(parents[lp], book);
      expect(costs[lp], 5);

      expect(parents[poster], book);
      expect(costs[poster], 0);
    });

    test('Second table is correct', () {
      final Map<Node, double> costs = <Node, double>{};
      costs[piano] = 100000;
      costs[guitar] = 100000;
      costs[drums] = 10000;
      costs[poster] = 100000;
      costs[lp] = 100000;
      costs[book] = 0;

      book.children.forEach((Node node, double cost) {
        final double newCost = cost + costs[book]!;

        if (newCost < costs[node]!) {
          costs[node] = newCost;
        }
      });

      lp.children.forEach((Node node, double cost) {
        final double newCost = cost + costs[lp]!;

        if (newCost < costs[node]!) {
          costs[node] = newCost;
        }
      });

      poster.children.forEach((Node node, double cost) {
        final double newCost = cost + costs[poster]!;

        if (newCost < costs[node]!) {
          costs[node] = newCost;
        }
      });

      drums.children.forEach((Node node, double cost) {
        final double newCost = cost + costs[drums]!;

        if (newCost < costs[node]!) {
          costs[node] = newCost;
        }
      });

      guitar.children.forEach((Node node, double cost) {
        final double newCost = cost + costs[guitar]!;

        if (newCost < costs[node]!) {
          costs[node] = newCost;
        }
      });

      expect(costs[lp], 5);
      expect(costs[poster], 0);
      expect(costs[guitar], 20);
      expect(costs[drums], 25);
      expect(costs[piano], 35);
    });

    test('General table is correct', () {
      final Map<Node, double> costs = <Node, double>{};
      final List<Node> nodes = <Node>[book, lp, poster, guitar, drums, piano];

      for (final Node node in nodes) {
        costs[node] = node == nodes.first ? 0 : double.infinity;
      }

      for (final Node parent in nodes) {
        if (parent.children.isNotEmpty) {
          parent.children.forEach((Node child, double cost) {
            final double newCost = cost + costs[parent]!;

            if (newCost < costs[child]!) {
              costs[child] = newCost;
            }
          });
        }
      }

      expect(costs[lp], 5);
      expect(costs[poster], 0);
      expect(costs[guitar], 20);
      expect(costs[drums], 25);
      expect(costs[piano], 35);
    });

    test('Save correct parent (shortest path to that node) of each node', () {
      final Map<Node, double> costs = <Node, double>{};
      final Map<Node, Node> parents = <Node, Node>{};
      final List<Node> nodes = <Node>[book, lp, poster, guitar, drums, piano];

      for (final Node node in nodes) {
        costs[node] = node == nodes.first ? 0 : double.infinity;
      }

      for (final Node parent in nodes) {
        if (parent.children.isNotEmpty) {
          parent.children.forEach((Node child, double cost) {
            final double newCost = cost + costs[parent]!;

            if (newCost < costs[child]!) {
              parents[child] = parent;
              costs[child] = newCost;
            }
          });
        }
      }

      expect(costs[lp], 5);
      expect(costs[poster], 0);
      expect(costs[guitar], 20);
      expect(costs[drums], 25);
      expect(costs[piano], 35);

      expect(parents[piano], drums);
      expect(parents[drums], lp);
      expect(parents[lp], book);
      expect(parents[book], null);
    });

    test('Find shortest path for each node', () {
      final Map<Node, double> costs = <Node, double>{};
      final Map<Node, Node> parents = <Node, Node>{};
      final List<Node> nodes = <Node>[book, lp, poster, guitar, drums, piano];

      for (final Node node in nodes) {
        costs[node] = node == nodes.first ? 0 : double.infinity;
      }

      for (final Node parent in nodes) {
        if (parent.children.isNotEmpty) {
          parent.children.forEach((Node child, double cost) {
            final double newCost = cost + costs[parent]!;

            if (newCost < costs[child]!) {
              parents[child] = parent;
              costs[child] = newCost;
            }
          });
        }
      }

      // final String shortestPath = '${parents[parents[parents[piano]]]} '
      //     '=> ${parents[parents[piano]]} '
      //     '=> ${parents[piano]} '
      //     '=> $piano';

      final StringBuffer shortestPath = StringBuffer();
      Node? goal = piano;

      shortestPath.write(piano);

      while (parents[goal] != null) {
        shortestPath.write(' <= ${parents[goal]}');
        goal = parents[goal];
      }

      print(shortestPath);
    });

    test('test Dijkstra class', () {
      final List<Node> nodes = <Node>[book, lp, poster, guitar, drums, piano];
      final double weightOfShortestPathToPiano = Dijkstra.findShortestPath(
        destination: piano,
        graph: nodes,
      );

      expect(weightOfShortestPathToPiano, 35);

      // Test exercises at page 139
      // Exercise A:
      final Node finish = Node('Finish');
      final Node d = Node('D')..children = <Node, double>{finish: 1};
      final Node c = Node('C')..children = <Node, double>{finish: 3, d: 6};
      final Node a = Node('A')..children = <Node, double>{c: 4, d: 2};
      final Node b = Node('B')..children = <Node, double>{a: 8, d: 7};
      final Node start = Node('Start')..children = <Node, double>{a: 5, b: 2};

      expect(
          Dijkstra.findShortestPath(
              destination: finish, graph: <Node>[start, a, b, c, d, finish]),
          8);

      // Exercise B:
      final Node bFinish = Node('B-Finish');
      final Node bC = Node('B-C');
      final Node bB = Node('B-B')
        ..children = <Node, double>{bC: 1, bFinish: 30};
      final Node bA = Node('B-A')..children = <Node, double>{bB: 20};
      final Node bStart = Node('B-Start')..children = <Node, double>{bA: 10};

      // As node c is child of nod b, so we have to define it before defining
      // node b. And because node c has node a as its child, we have to
      // initialize children of node c after defining node a.
      /// THAT'S WHY THE [Node] CLASS IS DEFINED LIKE THIS (WITH A SETTER AND
      /// GETTER FOR ITS [_children] variable, AND DIDN'T DEFINE [_children] AS
      /// PARAMETER (LIKE Node(children: ...))).
      bC.children = <Node, double>{bA: 1};

      expect(
          Dijkstra.findShortestPath(
              destination: bFinish, graph: <Node>[bStart, bA, bB, bC, bFinish]),
          60);

      // Exercise C:
      final Node cStart = Node('C-Start');
      final Node cA = Node('C-A');
      final Node cB = Node('C-B');
      final Node cC = Node('C-C');
      final Node cFinish = Node('C-Finish');

      cStart.children = <Node, double>{cA: 2, cB: 2};
      cA.children = <Node, double>{cC: 2, cFinish: 2};
      cB.children = <Node, double>{cA: 2};
      cC.children = <Node, double>{cB: -1, cFinish: 2};

      expect(
          Dijkstra.findShortestPath(
              destination: cFinish, graph: <Node>[cStart, cA, cB, cC, cFinish]),
          4);
    });
  });
}
