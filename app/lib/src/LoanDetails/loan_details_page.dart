import 'package:flutter/material.dart';

class LoanDetailsPage extends StatelessWidget {
  const LoanDetailsPage({super.key, required this.loanId});

  // loan id
  final String loanId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan details')),
      body: Center(
        child: Text('Loan details page for: $loanId'),
      ),
    );
  }
}
