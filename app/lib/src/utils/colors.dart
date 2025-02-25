import 'package:app/src/LoanDetails/models/loan_model.dart';
import 'package:flutter/material.dart';

final List<Color> levelColors = [
  Colors.indigo[50]!, // Level 0 (Root)
  Colors.indigo[100]!, // Level 1ä
  Colors.indigo[200]!, // Level 2ä
  Colors.indigo[300]!, // Level 3
  Colors.indigo[400]!, // Level 4
];

Color getStatusBgColor(int status) {
  return status == 1
      ? Color.fromARGB(
          255,
          4,
          217,
          96,
        )
      : Color.fromARGB(255, 242, 41, 152);
}

Color getStatusTextColor(int status) {
  return status == 1 ? Colors.black : Colors.white;
}

Color TimeCardBoxColor(LoanModel loan) {
  final DateTime? leaseEnd = loan.leaseEndDate;
  final DateTime? returned = loan.returnedAt;
  if (returned == null) {
    // Not yet returned
    return Colors.blueGrey;
  } else if (leaseEnd != null &&
      (returned.isBefore(leaseEnd) || returned.isAtSameMomentAs(leaseEnd))) {
    // Returned on time
    return Color.fromARGB(255, 4, 217, 96);
  } else {
    // Returned too late
    return const Color.fromARGB(255, 252, 70, 97);
  }
}
