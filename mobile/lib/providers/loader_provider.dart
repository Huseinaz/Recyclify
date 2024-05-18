import 'package:flutter/material.dart';

class LoaderProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setDisable(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
