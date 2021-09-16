import 'dart:collection';

/// Represents a node in the graph.
class Node {
  /// Constructs a Node.
  Node(
    this.name, {
    this.children,
  });

  /// Name of the node.
  final String name;

  /// Children of the node.
  final List<Node>? children;

  @override
  String toString() => 'Node($name)';
}

/// A graph example from `Grokking Algorithm book`.
class MangoGraph {
  static Node generateGraphUsingNodeClass() {
    final Node anuj = Node('Anuj');
    final Node peggy = Node('Peggy');
    final Node jonny = Node('Jonny');
    final Node thom = Node('Thom');
    final Node bob = Node('Bob', children: <Node>[anuj, peggy]);
    final Node alice = Node('Alice', children: <Node>[peggy]);
    final Node claire = Node('Claire', children: <Node>[thom, jonny]);
    final Node havir = Node('Havir', children: <Node>[bob, alice, claire]);

    return havir;
  }

  static HashMap<String, List<String>> generateGraphUsingHashMap() {
    final HashMap<String, List<String>> graph = HashMap<String, List<String>>();

    graph['Anuj'] = <String>[];
    graph['Peggy'] = <String>[];
    graph['Jonny'] = <String>[];
    graph['Thom'] = <String>[];
    graph['Bob'] = <String>['Anuj', 'Peggy'];
    graph['Alice'] = <String>['Peggy'];
    graph['Claire'] = <String>['Thom', 'Jonny'];
    graph['Havir'] = <String>['Bob', 'Alice', 'Claire'];

    return graph;
  }

  /// Using [Node] class
  void algorithmBFS() {
    final Queue<Node> queue = Queue<Node>();
    final Node graph = MangoGraph.generateGraphUsingNodeClass();
    final List<Node> searchedNodes = <Node>[];

    queue.addAll(graph.children!);

    while (queue.isNotEmpty) {
      final Node person = queue.removeFirst();

      if (!searchedNodes.contains(person)) {
        if (person.name == 'Peggy') {
          print('found it!');
        } else if (person.children != null) {
          queue.addAll(person.children!);
        }

        searchedNodes.add(person);
      }
    }
  }

  /// Using [Map].
  void algorithmBFSHashTable() {
    final Queue<String> queue = Queue<String>();
    final Map<String, List<String>> graph =
        MangoGraph.generateGraphUsingHashMap();

    queue.addAll(graph['Havir']!);

    while (queue.isNotEmpty) {
      final String person = queue.removeFirst();

      if (person == 'Peggy') {
        print('found it!');
      } else {
        if (graph[person] != null) {
          queue.addAll(graph[person]!);
        }
      }
    }
  }
}
