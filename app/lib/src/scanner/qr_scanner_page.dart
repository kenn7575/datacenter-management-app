import 'package:app/src/scanner/qr_scanner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QrScannerWidget(),
    );
  }
}
