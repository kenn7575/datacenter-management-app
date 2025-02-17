import 'package:app/src/LoanDetails/models/loan_details_model.dart';
import 'package:flutter/material.dart';

class LoanDetailsInfoWidget extends StatelessWidget {
  const LoanDetailsInfoWidget({super.key, required this.loanDetailsModel});

  final LoanDetailsModel loanDetailsModel;

  @override
  Widget build(BuildContext context) {
    return LoanDetailsCard(loanDetailsModel: loanDetailsModel);
  }
}

class LoanDetailsCard extends StatelessWidget {
  final LoanDetailsModel loanDetailsModel;

  const LoanDetailsCard({super.key, required this.loanDetailsModel});

  // Helper widget to build a details card for the provided title and data map.
  Widget buildDetailCard(String title, Map<String, String> details) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Display each key-value pair.
            ...details.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${entry.key}:",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(entry.value),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Convert the LoanModel to a Map for easier UI rendering.
  Map<String, String> getLoanDetailsMap() {
    final loan = loanDetailsModel.loanModel;
    return {
      'ID': '${loan.id}',
      'Loaner ID': loan.loanerId,
      'Item ID': '${loan.itemId}',
      'Name': loan.name,
      'Returned At': loan.returnedAt,
      'Created At': loan.createdAt?.toIso8601String() ?? 'N/A',
      'Updated At': loan.updatedAt?.toIso8601String() ?? 'N/A',
      'Lease End Date': loan.leaseEndDate?.toIso8601String() ?? 'N/A',
      'Status': loan.status ?? 'N/A',
      'Location': loan.location?.toString() ?? 'N/A',
    };
  }

  // Convert the ItemModel to a Map for easier UI rendering.
  Map<String, String> getItemDetailsMap() {
    final item = loanDetailsModel.itemModel;
    return {
      'ID': '${item.id}',
      'Machine type': item.parentId == null ? 'Physical' : "Virtuel",
      'Owner': item.owner,
      'Name': item.name,
      'OS': item.os,
      'Status': item.status,
      'Retirement': item.retirement.toIso8601String(),
      'Created At': item.createdAt.toIso8601String(),
      'Updated At': item.updatedAt.toIso8601String(),
      'Description': item.description ?? 'N/A',
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDetailCard("Loan Details", getLoanDetailsMap()),
          buildDetailCard("Item Details", getItemDetailsMap()),
        ],
      ),
    );
  }
}
