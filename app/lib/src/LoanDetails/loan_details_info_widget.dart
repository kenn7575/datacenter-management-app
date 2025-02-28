import 'package:app/src/LoanDetails/mesh_gradient_widget.dart';
import 'package:app/src/LoanDetails/models/loan_details_model.dart';
import 'package:app/src/LoanDetails/time_info_grid_widget.dart';
import 'package:app/src/utils/colors.dart';
import 'package:app/src/utils/custom_badge_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class LoanDetailsInfoWidget extends StatelessWidget {
  const LoanDetailsInfoWidget(
      {super.key, required this.loanDetailsModel, required this.onReturnLoan});

  final LoanDetailsModel loanDetailsModel;
  final VoidCallback onReturnLoan;

  @override
  Widget build(BuildContext context) {
    return LoanDetailsCard(
        loanDetailsModel: loanDetailsModel, onReturnLoan: onReturnLoan);
  }
}

// Page with blue header and a draggable scrollable sheet overlay.
class LoanDetailsCard extends StatelessWidget {
  final LoanDetailsModel loanDetailsModel;

  const LoanDetailsCard(
      {super.key, required this.loanDetailsModel, required this.onReturnLoan});

  final VoidCallback onReturnLoan;

  // Helper to build a row displaying a label and value.
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loan = loanDetailsModel.loanModel;
    final item = loanDetailsModel.itemModel;

    return Scaffold(
      body: Stack(
        children: [
          // Blue header background with device info.
          Stack(
            children: [
              AnimatedMeshGradientView(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 140, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Device Icon and basic info.
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.devices,
                            size: 30,
                            color: Color.fromARGB(255, 242, 41, 152),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Owner: ${item.owner}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Status and OS badges.
                    Row(
                      children: [
                        customBadgeBuilder(
                          (loan.status == 0) ? "Active" : "Inactive",
                          getStatusBgColor(loan.status),
                          getStatusTextColor(loan.status),
                          borderColor: getStatusTextColor(loan.status),
                        ),
                        const SizedBox(width: 12),
                        customBadgeBuilder(
                          item.os,
                          Color.fromARGB(255, 242, 41, 152),
                          Colors.white,
                          borderColor: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      item.description ?? "No Description",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.green, Colors.blueAccent],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //   ),
          //   padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          //   child:
          // Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // Device Icon and basic info.
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           CircleAvatar(
          //             radius: 30,
          //             backgroundColor: Colors.white,
          //             child: Icon(
          //               Icons.devices,
          //               size: 30,
          //               color: Colors.blueAccent,
          //             ),
          //           ),
          //           const SizedBox(width: 16),
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   item.name,
          //                   style: const TextStyle(
          //                     fontSize: 24,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //                 const SizedBox(height: 4),
          //                 Text(
          //                   "Owner: ${item.owner}",
          //                   style: const TextStyle(
          //                     color: Colors.white70,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(height: 16),
          //       // Status and OS badges.
          //       Row(
          //         children: [
          //           _buildBadge((loan.status ?? 0).toString(),
          //               _statusColor((loan.status ?? 0).toString())),
          //           const SizedBox(width: 12),
          //           _buildBadge(item.os, Colors.deepOrange),
          //         ],
          //       ),
          //       const SizedBox(height: 24),
          //       Text(
          //         item.description ?? "No Description",
          //         style: const TextStyle(color: Colors.white),
          //       ),
          //     ],
          //   ),
          // ),
          // Draggable Scrollable Sheet with additional details.
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.20,
            maxChildSize: 0.99,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // A grabber indicator.
                      Center(
                        child: Container(
                          width: 50,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // section title
                      Text(
                        "Loan Details",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Loan Bento Grid
                      LoanTimeInfoGrid(loan: loan),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                {context.push('/loans/${loan.id}/tree')},
                            child: Text("View Loan Tree"),
                          ),
                          ElevatedButton(
                            onPressed: onReturnLoan,
                            child: Text("Return Loan"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Blended Details
                      _buildDetailRow("Loan ID", loan.id.toString()),
                      const Divider(),
                      _buildDetailRow("Loaner ID", loan.loanerId),
                      const Divider(),
                      _buildDetailRow("Item ID", loan.itemId.toString()),

                      const Divider(),
                      _buildDetailRow(
                          "Description", item.description ?? "No Description"),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
