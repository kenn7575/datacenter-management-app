import 'dart:convert';

import 'package:app/src/LoanDetails/loan_details_info_widget.dart';
import 'package:app/src/LoanDetails/loan_details_provider.dart';
import 'package:app/src/LoanDetails/models/loan_details_model.dart';
import 'package:app/src/scanner/scanner_provider.dart';
import 'package:app/src/utils/errors.dart';
import 'package:app/src/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//TODO: revome sample json and use the actual json from the provider
String jsonString = '''
{
  "loan": {
    "id": 1,
    "itemId": 1,
    "loanerId": "fgsda-skdsd-asgss-sdfsf",
    "returnedAt": "2024-01-02T12:00:00.000Z",
    "createdAt": "2024-01-01T12:00:00.000Z",
    "updatedAt": "2024-01-02T12:00:00.000Z",
    "leaseEndDate": "2024-01-31T23:59:59.999Z",
    "status": "Active",
    "name": "Device A",
    "location": 1
  },
  "item": {
    "id": 1,
    "name": "Device A",
    "owner": "Alice",
    "os": "Windows",
    "status": "Active",
    "retirement": "2025-12-31T23:59:59.999Z",
    "createdAt": "2024-01-01T12:00:00.000Z",
    "updatedAt": "2024-01-02T12:00:00.000Z",
    "description": "This is a device",
    "parentId": null
    }
}
''';
Map<String, dynamic> jsonMap = jsonDecode(jsonString);
// LoanDetailsModel loanDetailsPlaceholder = LoanDetailsModel.fromJson(jsonMap);

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
        .fetchLoanDetails(idAsInt);
  }

  @override
  Widget build(BuildContext context) {
    LoanDetailsModel? loanDetails =
        Provider.of<LoanDetailsProvider>(context, listen: true)
            .loanDetailsModel;
    Failure? failure;
    // = Provider.of<LoanDetailsProvider>(context, listen: true).failure;

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
        body: loanDetails == null
            ? LoadingWidget(title: "Loading loan details...")
            : loanDetails != null
                ? LoanDetailsInfoWidget(
                    loanDetailsModel: loanDetails,
                  )
                : Center(
                    child: Text("FEJL"),
                  ));
  }
}
