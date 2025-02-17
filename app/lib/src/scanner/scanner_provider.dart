import 'package:flutter/material.dart';

class ScannerProvider extends ChangeNotifier {
  bool _scannerIsActive = true;

  bool get scannerIsActive => _scannerIsActive;

  void enableScanner() {
    _scannerIsActive = true;
    notifyListeners();
  }

  void disableScanner() {
    _scannerIsActive = false;
    notifyListeners();
  }
}
