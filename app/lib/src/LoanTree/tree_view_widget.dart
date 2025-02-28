import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:app/src/LoanTree/build_tree_widget.dart';
import 'package:app/src/LoanTree/loan_details_provider.dart';
import 'package:app/src/LoanTree/loan_item_model.dart';
import 'package:app/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TreeViewWidget extends StatefulWidget {
  const TreeViewWidget({super.key, required this.loanId, required this.items});

  final String loanId;
  final List<ItemTreeModel> items;

  @override
  State<TreeViewWidget> createState() => _TreeViewWidgetState();
}

class _TreeViewWidgetState extends State<TreeViewWidget> {
  final GlobalKey<SliverTreeViewState> _simpleTreeKey =
      GlobalKey<SliverTreeViewState>();
  final AutoScrollController scrollController = AutoScrollController();
  late int idAsInt;
  TreeViewController? _controller;

  @override
  void initState() {
    super.initState();
    idAsInt = int.parse(widget.loanId);
    Provider.of<LoanTreeProvider>(context, listen: false)
        .fetchLoanItems(idAsInt);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              "Tree of machines",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),

        /// Simple [SliverTreeView] example
        SliverTreeView.simple(
          key: _simpleTreeKey,
          tree: buildTreeFromList(widget.items), // Handle null case
          scrollController: scrollController,
          showRootNode: false,
          focusToNewNode: true,
          onTreeReady: (controller) {
            _controller = controller;
            controller.expandAllChildren(controller.tree);
          },
          builder: (context, node) {
            ItemTreeModel? item = node.data;
            Color nodeColor = levelColors[node.level % levelColors.length];
            return Card(
              color: nodeColor,
              child: InkWell(
                onTap: () {
                  // navigate to the loan details page
                  // if (item?.id == null) return;
                  // context.push("/loans/${item?.id}/details");
                },
                child: ListTile(
                  title: Text(item?.name ?? "No title"),
                  subtitle: (item?.owner != "" && item?.os != "")
                      ? Text('Owner: ${item?.owner} - OS: ${item?.os}')
                      : Text(""),
                  trailing: Text((item?.status == 0) ? "Active" : "Inactive"),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
