import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/firestore_service.dart';

class TransactionProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _error;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Calculate total balance
  double get totalBalance {
    double income = _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
    double expenses = _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
    return income - expenses;
  }

  // Calculate monthly income
  double get monthlyIncome {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    return _transactions
        .where((t) => 
            t.type == TransactionType.income && 
            t.date.isAfter(startOfMonth.subtract(const Duration(days: 1))))
        .fold(0, (sum, t) => sum + t.amount);
  }

  // Calculate monthly expenses
  double get monthlyExpenses {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    return _transactions
        .where((t) => 
            t.type == TransactionType.expense && 
            t.date.isAfter(startOfMonth.subtract(const Duration(days: 1))))
        .fold(0, (sum, t) => sum + t.amount);
  }

  // Get recent transactions (last 5)
  List<Transaction> get recentTransactions {
    final sorted = List<Transaction>.from(_transactions)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(5).toList();
  }

  // Initialize transactions stream for a user
  void initializeTransactions(String userId) {
    _firestoreService.getTransactionsStream(userId).listen(
      (transactions) {
        _transactions = transactions;
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

  // Add a new transaction
  Future<void> addTransaction(Transaction transaction, String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.addTransaction(transaction, userId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update a transaction
  Future<void> updateTransaction(Transaction transaction, String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateTransaction(transaction, userId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a transaction
  Future<void> deleteTransaction(String transactionId, String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.deleteTransaction(transactionId, userId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear transactions (for logout)
  void clearTransactions() {
    _transactions = [];
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  // Get transactions by category
  List<Transaction> getTransactionsByCategory(String category) {
    return _transactions.where((t) => t.category == category).toList();
  }

  // Get expense categories with totals
  Map<String, double> getExpenseCategories() {
    final expenseCategories = <String, double>{};
    for (final transaction in _transactions) {
      if (transaction.type == TransactionType.expense) {
        expenseCategories[transaction.category] = 
            (expenseCategories[transaction.category] ?? 0) + transaction.amount;
      }
    }
    return expenseCategories;
  }

  // Get transactions for a specific date range
  List<Transaction> getTransactionsByDateRange(DateTime start, DateTime end) {
    return _transactions
        .where((t) => t.date.isAfter(start.subtract(const Duration(days: 1))) && 
                     t.date.isBefore(end.add(const Duration(days: 1))))
        .toList();
  }
}
