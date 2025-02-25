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
    "returnedAt": "2024-02-02T12:00:00.000Z",
    "createdAt": "2024-01-01T12:00:00.000Z",
    "updatedAt": "2024-01-02T12:00:00.000Z",
    "leaseEndDate": "2024-01-31T23:59:59.999Z",
    "status": 1,
    "name": "Device A",
    "location": 1
  },
  "item": {
    "id": 1,
    "name": "Device A",
    "owner": "Alice",
    "os": "Windows",
    "status": 1,
    "retirement": "2025-12-31T23:59:59.999Z",
    "createdAt": "2024-01-01T12:00:00.000Z",
    "updatedAt": "2024-01-02T12:00:00.000Z",
    "description": "This is a device that where installed in the rack, for the purpose of testing a new cisco update.",
    "parentId": null
    }
}
''';
Map<String, dynamic> jsonMap = jsonDecode(jsonString);
LoanDetailsModel loanDetailsPlaceholder = LoanDetailsModel.fromJson(jsonMap);

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

  Future<void> _confirmReturnLoan(BuildContext context, int loanId) async {
    final provider = Provider.of<LoanDetailsProvider>(context, listen: false);
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Return'),
        content: Text('Are you sure you want to return this loan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await provider.returnLoan(loanId);
    }
  }

  @override
  Widget build(BuildContext context) {
    LoanDetailsModel? loanDetails =
        Provider.of<LoanDetailsProvider>(context, listen: true)
            .loanDetailsModel;
    Failure? failure;
    // = Provider.of<LoanDetailsProvider>(context, listen: true).failure;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        title: Text('Loan ${widget.loanId} Details',
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                  onReturnLoan: () => _confirmReturnLoan(context, idAsInt),
                )
              : Center(
                  child: Text("FEJL"),
                ),
    );
  }
}
