/// Represent a node in the weighted graph.
class Node {
  /// Constructs a Node.
  Node({
    required this.value,
    this.leftNode,
    this.rightNode,
  });

  /// Weight of the node.
  int value;

  /// Left child of the node.
  Node? leftNode;

  /// Right child of the node.
  Node? rightNode;

  @override
  String toString() {
    final String root = 'Node($value ,'
        'left:${leftNode != null ? leftNode!.value : null} ,'
        'right:${rightNode != null ? rightNode!.value : null})';

    if (_isLeaf) {
      return root;
    } else if (_hasOnlyOneChild) {
      if (leftNode != null) {
        return '$root\n${leftNode.toString()}';
      }

      return '$root\n${rightNode.toString()}';
    }

    return '$root\n${leftNode.toString()}\n${rightNode.toString()}';
  }

  bool get _isLeaf => leftNode == null && rightNode == null;

  bool get _hasOnlyOneChild =>
      (leftNode == null && rightNode != null) ||
      (leftNode != null && rightNode == null);
}

/// Implementation of Binary Search Tree.
class BST {
  /// Constructs a BST.
  BST({this.root});

  /// The root node.
  Node? root;

  /// Inserts a node to the tree.
  Node insert({
    required Node item,
    Node? root,
  }) {
    if (this.root == null) {
      this.root = item;
    } else if (item.value < this.root!.value) {
      insert(item: item, root: this.root!.leftNode);
    } else if (item.value > this.root!.value) {
      insert(item: item, root: this.root!.rightNode);
    }

    return this.root!;
  }

  /// Removes a note from the tree.
  ///
  /// When we want to remove a node from BST there are three scenarios:
  /// 1- If the node is leaf:
  ///   Just remove the node.
  /// 2- If the node has only one child:
  ///   Replace the child with the node.
  /// 3- If the node has two children:
  ///   Find the successor. Replace successor with the node. Remove the
  ///   duplicated successor.
  ///
  /// *Successor: successor is the minimum element of the right subtree.
  static Node? remove(Node item, Node root) {
    // Find the parent of the node (item).
    final Node? parent = _findParent(item, root);

    // If parent is null, then it's root. So, the whole tree will be deleted. So
    // we return null.
    if (parent == null) {
      return null;
    }

    if (_isLeaf(item)) {
      // Case1: remove the node.
      parent.leftNode == item
          ? parent.leftNode = null
          : parent.rightNode = null;
    } else if (_hasOnlyOneChild(item)) {
      // Case2: replace child with the node.
      final Node child = item.leftNode ?? item.rightNode!;

      parent.leftNode == item
          ? parent.leftNode = child
          : parent.rightNode = child;
    } else {
      // Case3: find the successor.
      final Node successor = _minimum(item.rightNode!);

      // Remove successor recursively.
      remove(successor, root);

      // Replace value of successor to the item.
      item.value = successor.value;
    }

    return root;
  }

  static Node? removeRecursively(Node item, Node? root) {
    // Return if tree is empty.
    if (root == null) {
      return null;
    }

    // Find the node to be deleted
    if (item.value < root.value) {
      root.leftNode = removeRecursively(item, root.leftNode);
    } else if (item.value > root.value) {
      root.rightNode = removeRecursively(item, root.rightNode);
    } else {
      // Case1&2: If item has no child or only one child.
      if (item.leftNode == null) {
        return item.rightNode;
      } else if (item.rightNode == null) {
        return item.leftNode;
      }

      // Case3: If item has two children.
      // Find successor of item and copy its value to the root value.
      final Node successor = _minimum(item.rightNode!);
      root.value = successor.value;

      // Remove the successor.
      root.rightNode = removeRecursively(root, root.rightNode!);
    }

    return root;
  }

  static Node _minimum(Node node) {
    if (_isLeaf(node)) {
      return node;
    } else if (_hasOnlyOneChild(node)) {
      return node.leftNode != null ? node.leftNode! : node;
    }

    return _minimum(node.leftNode!);
  }

  static Node? _findParent(Node item, Node root) {
    // find parent of the [item].
    Node? parent;
    Node? current = root;

    while (current != null && current.value != item.value) {
      parent = current;

      if (current.value > item.value) {
        current = current.leftNode;
      } else {
        current = current.rightNode;
      }
    }

    return parent;
  }

  static bool _isLeaf(Node node) =>
      node.leftNode == null && node.rightNode == null;

  static bool _hasOnlyOneChild(Node node) =>
      (node.leftNode == null && node.rightNode != null) ||
      (node.leftNode != null && node.rightNode == null);
}
