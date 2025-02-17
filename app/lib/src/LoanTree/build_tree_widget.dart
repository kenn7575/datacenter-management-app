import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:app/src/LoanTree/loan_item_model.dart';

TreeNode<ItemModel> buildTree(ItemModel item) {
  return TreeNode(
    key: item.name, // Unique key for each node
    data: item, // Store the ItemModel in the node
  )..addAll(item.childData.map(buildTree)); // Recursively add child nodes
}

TreeNode<ItemModel> buildTreeFromList(List<ItemModel> items) {
  if (items.isEmpty) {
    return TreeNode.root();
  }

  TreeNode<ItemModel> root = TreeNode.root(
      data: ItemModel(
    id: 0,
    owner: "",
    name: "Datacenter",
    os: "",
    status: 0,
    retirement: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    childData: [],
  )); // Root without data

  final Map<int, TreeNode<ItemModel>> nodeMap = {};

  // Step 1: Create all nodes and store them in a map
  for (var item in items) {
    nodeMap[item.id] = TreeNode<ItemModel>(key: item.name, data: item);
  }

  // Step 2: Assign children based on `parentId`
  for (var item in items) {
    var node = nodeMap[item.id]!;

    if (item.parentId == null) {
      root.add(node); // Top-level nodes attach directly to root
    } else {
      TreeNode<ItemModel>? parent = nodeMap[item.parentId];
      if (parent != null) {
        parent.add(node); // Attach to parent
      }
    }

    // Step 3: Attach nested `childData` recursively
    for (var child in item.childData) {
      var childNode = buildTree(child); // Recursively build
      node.add(childNode); // Attach to its parent
    }
  }

  return root;
}
