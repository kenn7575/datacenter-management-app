import 'dart:convert';
import 'package:app/src/LoanDetails/loan_details_provider.dart';
import 'package:app/src/LoanDetails/loan_item_model.dart';
import 'package:app/src/LoanDetails/tree_view_widget.dart';
import 'package:app/src/scanner/scanner_provider.dart';
import 'package:app/src/utils/errors.dart';
import 'package:app/src/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//TODO: revome sample json and use the actual json from the provider
String jsonString = '''
{
  "id": 1,
  "name": "Device A",
  "owner": "Alice",
  "os": "Windows",
  "status": "Active",
  "retirement": "2025-12-31T23:59:59.999Z",
  "createdAt": "2024-01-01T12:00:00.000Z",
  "updatedAt": "2024-01-02T12:00:00.000Z",
  "childData": [
    {
      "id": 2,
      "name": "Device B",
      "owner": "Alice",
      "os": "Linux",
      "status": "Retired",
      "retirement": "2023-06-15T10:30:00.000Z",
      "createdAt": "2023-01-01T08:00:00.000Z",
      "updatedAt": "2023-01-02T08:00:00.000Z",
      "parentId": 1
    }
  ]
}
''';
Map<String, dynamic> jsonMap = jsonDecode(jsonString);
ItemModel item = ItemModel.fromJson(jsonMap);

class LoanDetailsPage extends StatefulWidget {
  const LoanDetailsPage({super.key, required this.loanId});

  final String loanId;

  @override
  State<LoanDetailsPage> createState() => _LoanDetailsPageState();
}

class _LoanDetailsPageState extends State<LoanDetailsPage> {
  late int idAsInt;

  @override
  void initState() {
    super.initState();
    idAsInt = int.parse(widget.loanId);
    Provider.of<LoanDetailsProvider>(context, listen: false)
        .fetchLoanItems(idAsInt);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: uncomment this line to get the actual item from the provider
    ItemModel? item =
        Provider.of<LoanDetailsProvider>(context, listen: true).loanItems;
    Failure? failure =
        Provider.of<LoanDetailsProvider>(context, listen: true).failure;

    return Scaffold(
        appBar: AppBar(
          title: Text('Loan ${widget.loanId} Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<ScannerProvider>(context, listen: false)
                  .enableScanner();
              context.pop();
            },
          ),
        ),
        body: item == null && failure == null
            ? LoadingWidget(title: "Loading loan details...")
            : failure != null
                ? Center(
                    child: Text(failure.errorMessage),
                  )
                : TreeViewWidget(
                    loanId: widget.loanId,
                    items: item != null ? [item] : [],
                  ));
  }
}
