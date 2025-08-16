import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Sign in with email and password
  Future<bool> signInWithEmailPassword(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      UserCredential? result = await _authService.signInWithEmailPassword(email, password);
      _setLoading(false);
      return result != null;
  } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Register with email and password
  Future<bool> registerWithEmailPassword(
    String email, 
    String password, 
    String fullName, {
    String? studentId,
    String? university,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      UserCredential? result = await _authService.registerWithEmailPassword(
        email, 
        password, 
        fullName,
        studentId: studentId,
        university: university,
      );
      _setLoading(false);
      return result != null;
    } catch (e) {
      String errorMessage = e.toString();
      // Clean up error message (remove "Exception: " prefix if present)
  if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11);
      }
      _setError(errorMessage);
      _setLoading(false);
      return false;
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();

    try {
      UserCredential? result = await _authService.signInWithGoogle();
      _setLoading(false);
      return result != null;
    } catch (e) {
      String errorMessage = e.toString();
      // Clean up error message (remove "Exception: " prefix if present)
  if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11);
      }
      _setError(errorMessage);
      _setLoading(false);
      return false;
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.resetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      String errorMessage = e.toString();
  if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11);
      }
      _setError(errorMessage);
      _setLoading(false);
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    _setLoading(true);
    _clearError();
    
    try {
  // Immediately reflect logged-out state to avoid redirect loops
  _user = null;
  notifyListeners();
  await _authService.signOut();
  } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11);
      }
      _setError(errorMessage);
    }
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
