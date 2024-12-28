import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().login(email, password);
      print("User logged in: $response");
    } catch (error) {
      print("Login error: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
