// ignore: depend_on_referenced_packages
import 'package:app/src/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:app/src/LoanDetails/models/loan_model.dart';
import 'package:flutter/material.dart';

class LoanTimeInfoGrid extends StatelessWidget {
  final LoanModel loan;

  const LoanTimeInfoGrid({super.key, required this.loan});

  // Helper to format dates using intl package.
  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Helper to calculate days difference (absolute integer).
  int _daysDifference(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }

  // Determine the background color for the return date box.
  // Green if returned on time, red if too late, blueGrey if not yet returned.

  // Build a single rounded box with a large number/text and a smaller description.
  Widget _buildBox({
    required String bigText,
    required String smallText,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bigText,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 8),
          Text(
            smallText,
            style: TextStyle(fontSize: 14, color: textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime? returnedAt = loan.returnedAt;

    // Box 1: Days since last updated.
    // Ensure loan.updatedAt is non-null.
    final DateTime updatedAt = loan.updatedAt ?? now;
    final int daysSinceUpdated = _daysDifference(updatedAt, now);
    final String updatedFormatted = _formatDate(updatedAt);

    // Box 2: Days since loan was created.
    final DateTime createdAt = loan.createdAt ?? now;
    final int daysSinceCreated = _daysDifference(createdAt, now);
    final String createdFormatted = _formatDate(createdAt);

    // Box 3: Days until the loan has to be returned.
    // If leaseEndDate is in the past, we'll show a negative number.
    final DateTime leaseEnd = loan.leaseEndDate ?? now;
    final String daysUntilReturn = returnedAt == null
        ? _daysDifference(now, leaseEnd).toString()
        : "Returned";
    final String leaseFormatted = returnedAt == null
        ? "Days until return\n${_formatDate(leaseEnd)}"
        : _formatDate(leaseEnd);

    // Box 4: The return date, or "Not yet returned" if parsing fails.
    final DateTime? endLease = loan.leaseEndDate;
    final String returnedText =
        returnedAt != null ? _formatDate(returnedAt) : "Not yet returned";
    final int? daysComparison = (returnedAt == null || endLease == null)
        ? null
        : _daysDifference(returnedAt, endLease);
    final String timeDescription = daysComparison == null
        ? ""
        : daysComparison > 0
            ? "Returned ${daysComparison.abs()} days late"
            : daysComparison < 0
                ? "Returned ${daysComparison.abs()} days early"
                : "Returned on time";

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Box 1: Days since last updated.
        _buildBox(
          bigText: "$daysSinceUpdated",
          smallText: "Days since updated\n($updatedFormatted)",
        ),
        // Box 2: Days since loan was created.
        _buildBox(
          bigText: "$daysSinceCreated",
          smallText: "Days since created\n($createdFormatted)",
        ),
        // Box 3: Days until the loan has to be returned.
        _buildBox(
          bigText: daysUntilReturn,
          smallText: "($leaseFormatted)",
        ),
        // Box 4: Return date.
        _buildBox(
          bigText: returnedText,
          smallText: timeDescription,
          backgroundColor: TimeCardBoxColor(loan),
        ),
      ],
    );
  }
}
