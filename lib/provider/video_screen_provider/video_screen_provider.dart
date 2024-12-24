import 'package:flutter/material.dart';

class VideoScreenProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _isCompleted = false;

  bool get isLoading => _isLoading;
  bool get isCompleted => _isCompleted;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCompleted(bool value) {
    _isCompleted = value;
    notifyListeners();
  }
}
