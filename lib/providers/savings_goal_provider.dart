import 'package:flutter/material.dart';
import '../models/savings_goal.dart';
import '../services/firestore_service.dart';

class SavingsGoalProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<SavingsGoal> _savingsGoals = [];
  bool _isLoading = false;
  String? _error;

  List<SavingsGoal> get savingsGoals => _savingsGoals;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Calculate total saved amount
  double get totalSaved {
    return _savingsGoals.fold(0.0, (sum, goal) => sum + goal.currentAmount);
  }

  // Get active goals (not yet reached)
  List<SavingsGoal> get activeGoals {
    return _savingsGoals.where((goal) => goal.currentAmount < goal.targetAmount).toList();
  }

  // Get completed goals
  List<SavingsGoal> get completedGoals {
    return _savingsGoals.where((goal) => goal.currentAmount >= goal.targetAmount).toList();
  }

  // Initialize savings goals stream for a user
  void initializeSavingsGoals(String userId) {
    _firestoreService.getSavingsGoalsStream(userId).listen(
      (goals) {
        _savingsGoals = goals;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (error) {
        _error = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // Add a new savings goal
  Future<void> addSavingsGoal(SavingsGoal goal, String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.addSavingsGoal(goal, userId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update a savings goal (e.g., add money to it)
  Future<void> updateSavingsGoal(SavingsGoal goal, String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateSavingsGoal(goal, userId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a savings goal
  Future<void> deleteSavingsGoal(String goalId, String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.deleteSavingsGoal(goalId, userId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add money to a specific savings goal
  Future<void> addMoneyToGoal(String goalId, double amount, String userId) async {
    try {
      final goalIndex = _savingsGoals.indexWhere((goal) => goal.id == goalId);
      if (goalIndex != -1) {
        final updatedGoal = _savingsGoals[goalIndex].copyWith(
          currentAmount: _savingsGoals[goalIndex].currentAmount + amount,
        );
        await updateSavingsGoal(updatedGoal, userId);
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Clear savings goals (for logout)
  void clearSavingsGoals() {
    _savingsGoals = [];
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  // Get goals by category
  List<SavingsGoal> getGoalsByCategory(String category) {
    return _savingsGoals.where((goal) => goal.category == category).toList();
  }

  // Calculate total target amount
  double get totalTargetAmount {
    return _savingsGoals.fold(0.0, (sum, goal) => sum + goal.targetAmount);
  }

  // Calculate overall progress percentage
  double get overallProgress {
    if (totalTargetAmount == 0) return 0.0;
    return totalSaved / totalTargetAmount;
  }
}
