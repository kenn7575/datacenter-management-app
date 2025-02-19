import 'package:app/src/scanner/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrScannerWidget extends StatelessWidget {
  const QrScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BarcodeScannerSimple(),
    );
  }
}

class BarcodeScannerSimple extends StatefulWidget {
  const BarcodeScannerSimple({super.key});

  @override
  State<BarcodeScannerSimple> createState() => _BarcodeScannerSimpleState();
}

class _BarcodeScannerSimpleState extends State<BarcodeScannerSimple> {
  void _handleBarcode(BarcodeCapture barcodes) {
    bool enabled =
        Provider.of<ScannerProvider>(context, listen: false).scannerIsActive;

    print("Scanned");
    if (mounted && enabled) {
      Provider.of<ScannerProvider>(context, listen: false).disableScanner();
      context.push('/loans/${barcodes.barcodes.firstOrNull?.displayValue}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Provider.of<ScannerProvider>(context, listen: false)
                  .disableScanner();
              context.push('/loans/1');
            },
            child: Text("Go to Loan 1")),
        Stack(
          children: [
            MobileScanner(
              onDetect: _handleBarcode,
              overlayBuilder: (context, constraints) => Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 4,
                    ),
                  ),
                ),
              ),
              scanWindow: Rect.fromCenter(
                center: MediaQuery.of(context).size.center(Offset.zero),
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
