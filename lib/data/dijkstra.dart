/// Represent a node in a graph.
class Node {
  /// Constructs a [Node].
  Node(this.name);

  /// Name of the node.
  final String name;

  final Map<Node, double> _children = <Node, double>{};

  /// Setter for [_children] property.
  set children(Map<Node, double> children) {
    _children.addAll(children);
  }

  /// Getter for [_children] property.
  Map<Node, double> get children => _children;

  @override
  String toString() => 'Node($name)';
}

/// Implementation of Dijkstra algorithm.
class Dijkstra {
  /// Finds shortest path of a given weight graph from start node to the
  /// [destination].
  static double findShortestPath({
    required Node destination,
    required List<Node> graph,
  }) {
    final Map<Node, double> costs = <Node, double>{};
    final Map<Node, Node> parents = <Node, Node>{};

    for (final Node node in graph) {
      costs[node] = node == graph.first ? 0 : double.infinity;
    }

    // Todo(Havir): Use [HeapPriorityQueue] instead to decrease time complexity.
    for (final Node parent in graph) {
      if (parent.children.isNotEmpty) {
        parent.children.forEach((Node child, double cost) {
          final double newCost = costs[parent]! + cost;

          if (newCost < costs[child]!) {
            parents[child] = parent;
            costs[child] = newCost;
          }
        });
      }
    }

    // _printShortestPath(parents: parents, destination: destination);
    _recursivePrint(parents: parents, destination: destination);

    return costs[destination]!;
  }

  static void _printShortestPath({
    required Map<Node, Node> parents,
    required Node destination,
  }) {
    final StringBuffer shortestPath = StringBuffer();
    Node? goal = destination;

    shortestPath.write(destination);

    while (parents[goal] != null) {
      shortestPath.write(' <= ${parents[goal]}');
      goal = parents[goal];
    }

    print(shortestPath);
  }

  static void _recursivePrint({
    required Map<Node, Node> parents,
    Node? destination,
    String? path,
  }) {
    if (parents[destination] == null) {
      print(path);
    } else {
      _recursivePrint(
          parents: parents,
          destination: parents[destination],
          path: '${path ?? destination} <= ${parents[destination]}');
    }
  }
}
