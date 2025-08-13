import 'dart:ui';
import '../models/transaction.dart';
import '../models/savings_goal.dart';
import '../models/reminder.dart';
import '../models/chat_message.dart';

class MockData {
  static final List<Transaction> transactions = [
    Transaction(
      id: '1',
      amount: 25000,
      description: 'Spring Semester Tuition',
      category: 'Education',
      date: DateTime(2024, 1, 15),
      type: TransactionType.expense,
      icon: 'GraduationCap',
    ),
    Transaction(
      id: '2',
      amount: 2500,
      description: 'Part-time Campus Job',
      category: 'Income',
      date: DateTime(2024, 1, 14),
      type: TransactionType.income,
      icon: 'Briefcase',
    ),
    Transaction(
      id: '3',
      amount: 1200,
      description: 'Semester Registration Fee',
      category: 'Education',
      date: DateTime(2024, 1, 13),
      type: TransactionType.expense,
      icon: 'FileText',
    ),
    Transaction(
      id: '4',
      amount: 150,
      description: 'Campus Coffee Shop',
      category: 'Food',
      date: DateTime(2024, 1, 12),
      type: TransactionType.expense,
      icon: 'Coffee',
    ),
    Transaction(
      id: '5',
      amount: 500,
      description: 'One Card Top-up',
      category: 'Campus',
      date: DateTime(2024, 1, 11),
      type: TransactionType.expense,
      icon: 'CreditCard',
    ),
    Transaction(
      id: '6',
      amount: 800,
      description: 'Green Garden Cafeteria',
      category: 'Food',
      date: DateTime(2024, 1, 10),
      type: TransactionType.expense,
      icon: 'Utensils',
    ),
    Transaction(
      id: '7',
      amount: 300,
      description: 'Midterm Exam Fee',
      category: 'Education',
      date: DateTime(2024, 1, 9),
      type: TransactionType.expense,
      icon: 'BookOpen',
    ),
    Transaction(
      id: '8',
      amount: 400,
      description: 'Final Exam Fee',
      category: 'Education',
      date: DateTime(2024, 1, 8),
      type: TransactionType.expense,
      icon: 'Award',
    ),
  ];

  static final List<SavingsGoal> savingsGoals = [
    SavingsGoal(
      id: '1',
      title: 'Next Semester Tuition',
      targetAmount: 25000,
      currentAmount: 18500,
      deadline: DateTime(2024, 6, 30),
      category: 'Education',
      color: const Color(0xFF3B82F6),
    ),
    SavingsGoal(
      id: '2',
      title: 'Laptop for Studies',
      targetAmount: 45000,
      currentAmount: 28000,
      deadline: DateTime(2024, 8, 15),
      category: 'Technology',
      color: const Color(0xFF8B5CF6),
    ),
    SavingsGoal(
      id: '3',
      title: 'Study Abroad Program',
      targetAmount: 150000,
      currentAmount: 45000,
      deadline: DateTime(2024, 12, 31),
      category: 'Education',
      color: const Color(0xFF10B981),
    ),
    SavingsGoal(
      id: '4',
      title: 'Campus Emergency Fund',
      targetAmount: 10000,
      currentAmount: 6500,
      deadline: DateTime(2024, 5, 30),
      category: 'Emergency',
      color: const Color(0xFFF97316),
    ),
  ];

  static final List<Reminder> reminders = [
    Reminder(
      id: '1',
      title: 'Fall Semester Tuition Due',
      amount: 25000,
      dueDate: DateTime(2024, 2, 15),
      type: 'payment',
      isCompleted: false,
    ),
    Reminder(
      id: '2',
      title: 'Dormitory Rent Payment',
      amount: 8000,
      dueDate: DateTime(2024, 2, 1),
      type: 'bill',
      isCompleted: true,
    ),
    Reminder(
      id: '3',
      title: 'Final Assignment Submission',
      amount: 0,
      dueDate: DateTime(2024, 1, 25),
      type: 'deadline',
      isCompleted: false,
    ),
    Reminder(
      id: '4',
      title: 'One Card Renewal',
      amount: 500,
      dueDate: DateTime(2024, 2, 10),
      type: 'payment',
      isCompleted: false,
    ),
    Reminder(
      id: '5',
      title: 'Library Book Return',
      amount: 0,
      dueDate: DateTime(2024, 1, 28),
      type: 'deadline',
      isCompleted: false,
    ),
  ];

  static final List<ChatMessage> chatMessages = [
    ChatMessage(
      id: '1',
      message: 'Hi! I\'m your campus financial assistant. I can help you manage tuition, campus expenses, and student budgets. How can I help you today?',
      isUser: false,
      timestamp: DateTime(2024, 1, 20, 10, 0, 0),
    ),
    ChatMessage(
      id: '2',
      message: 'Can I afford to eat at Green Garden every day this month?',
      isUser: true,
      timestamp: DateTime(2024, 1, 20, 10, 1, 0),
    ),
    ChatMessage(
      id: '3',
      message: 'Based on your spending pattern, eating at Green Garden daily would cost around ৳2,400/month. With your current budget, I recommend limiting it to 3-4 times per week and using your One Card for discounts. This would save you ৳800-1,000 monthly!',
      isUser: false,
      timestamp: DateTime(2024, 1, 20, 10, 1, 30),
    ),
  ];
}
