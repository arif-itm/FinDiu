import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/transaction.dart' as AppTransaction;
import '../models/savings_goal.dart';
import '../models/reminder.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collections
  String get usersCollection => 'users';
  String get transactionsCollection => 'transactions';
  String get savingsGoalsCollection => 'savings_goals';
  String get remindersCollection => 'reminders';

  // User operations
  Future<void> createUser(User user) async {
    await _firestore.collection(usersCollection).doc(user.id).set(user.toMap());
  }

  Future<User?> getUser(String userId) async {
    DocumentSnapshot doc = await _firestore.collection(usersCollection).doc(userId).get();
    if (doc.exists) {
      return User.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await _firestore.collection(usersCollection).doc(user.id).update(user.toMap());
  }

  Stream<User?> getUserStream(String userId) {
    return _firestore.collection(usersCollection).doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return User.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  // Transaction operations
  Future<String> addTransaction(AppTransaction.Transaction transaction, String userId) async {
    DocumentReference docRef = await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(transactionsCollection)
        .add(transaction.toJson());
    return docRef.id;
  }

  Future<void> updateTransaction(AppTransaction.Transaction transaction, String userId) async {
    await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(transactionsCollection)
        .doc(transaction.id)
        .update(transaction.toJson());
  }

  Future<void> deleteTransaction(String transactionId, String userId) async {
    await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(transactionsCollection)
        .doc(transactionId)
        .delete();
  }

  Stream<List<AppTransaction.Transaction>> getTransactionsStream(String userId) {
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(transactionsCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppTransaction.Transaction.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Get transactions by date range
  Future<List<AppTransaction.Transaction>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(transactionsCollection)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => AppTransaction.Transaction.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
        .toList();
  }

  // Savings goal operations
  Future<String> addSavingsGoal(SavingsGoal goal, String userId) async {
    DocumentReference docRef = await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(savingsGoalsCollection)
        .add(goal.toJson());
    return docRef.id;
  }

  Future<void> updateSavingsGoal(SavingsGoal goal, String userId) async {
    await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(savingsGoalsCollection)
        .doc(goal.id)
        .update(goal.toJson());
  }

  Future<void> deleteSavingsGoal(String goalId, String userId) async {
    await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(savingsGoalsCollection)
        .doc(goalId)
        .delete();
  }

  Stream<List<SavingsGoal>> getSavingsGoalsStream(String userId) {
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(savingsGoalsCollection)
        .orderBy('targetDate')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SavingsGoal.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Reminder operations
  Future<String> addReminder(Reminder reminder, String userId) async {
    DocumentReference docRef = await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(remindersCollection)
        .add(reminder.toJson());
    return docRef.id;
  }

  Future<void> updateReminder(Reminder reminder, String userId) async {
    await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(remindersCollection)
        .doc(reminder.id)
        .update(reminder.toJson());
  }

  Future<void> deleteReminder(String reminderId, String userId) async {
    await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(remindersCollection)
        .doc(reminderId)
        .delete();
  }

  Stream<List<Reminder>> getRemindersStream(String userId) {
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(remindersCollection)
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Reminder.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Analytics helper methods
  Future<Map<String, double>> getExpensesByCategory(String userId, DateTime startDate, DateTime endDate) async {
    List<AppTransaction.Transaction> transactions = await getTransactionsByDateRange(userId, startDate, endDate);
    Map<String, double> categoryExpenses = {};

    for (AppTransaction.Transaction transaction in transactions) {
      if (transaction.type == AppTransaction.TransactionType.expense) {
        categoryExpenses[transaction.category] = 
            (categoryExpenses[transaction.category] ?? 0) + transaction.amount;
      }
    }

    return categoryExpenses;
  }

  Future<double> getTotalBalance(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(transactionsCollection)
        .get();

    double balance = 0;
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      AppTransaction.Transaction transaction = AppTransaction.Transaction.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
      if (transaction.type == AppTransaction.TransactionType.income) {
        balance += transaction.amount;
      } else {
        balance -= transaction.amount;
      }
    }

    return balance;
  }
}
