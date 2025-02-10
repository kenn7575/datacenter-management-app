import 'package:app/src/LoanDetails/loan_details_provider.dart';
import 'package:app/src/utils/errors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoanDetailsPage extends StatefulWidget {
  const LoanDetailsPage({super.key, required this.loanId});

  // loan id
  final String loanId;

  @override
  State<LoanDetailsPage> createState() => _LoanDetailsPageState();
}

class _LoanDetailsPageState extends State<LoanDetailsPage> {
  @override
  void initState() {
    super.initState();

    //fetch the loan details
    Provider.of<LoanDetailsProvider>(context, listen: false)
        .getSpecificLoan(int.parse(widget.loanId));

    // Get the loan details and handle any errors
    Failure? failure =
        Provider.of<LoanDetailsProvider>(context, listen: true).failure;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan details')),
      body: Center(
        child: Text('Loan details page for: ${widget.loanId}'),
      ),
    );
  }
}
