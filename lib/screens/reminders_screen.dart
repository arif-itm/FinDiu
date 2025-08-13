import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navigation.dart';
import '../models/reminder.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  List<Reminder> reminders = [
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
  ];

  String _getTypeIcon(String type) {
    switch (type) {
      case 'bill':
        return '💡';
      case 'payment':
        return '🎓';
      case 'deadline':
        return '📝';
      default:
        return '⏰';
    }
  }

  String _formatDate(DateTime date) {
    final today = DateTime.now();
    final difference = date.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 0) return '${difference.abs()} days overdue';
    return 'In $difference days';
  }

  void _toggleCompleted(String id) {
    setState(() {
      final index = reminders.indexWhere((r) => r.id == id);
      if (index != -1) {
        reminders[index] = reminders[index].copyWith(
          isCompleted: !reminders[index].isCompleted,
        );
      }
    });
  }

  int get pendingCount => reminders.where((r) => !r.isCompleted).length;
  int get completedCount => reminders.where((r) => r.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF8B5CF6), Color(0xFF10B981)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Header with back button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.go('/dashboard'),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              LucideIcons.arrowLeft,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Reminders',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Stats
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  pendingCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Pending',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  completedCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Container(
              transform: Matrix4.translationValues(0, -24, 0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                child: Column(
                  children: [
                    // Add Reminder Button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFF10B981)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              LucideIcons.plus,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Reminder',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              Text(
                                'Never miss a payment again',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Reminders List
                    ...reminders.map((reminder) {
                      final isOverdue = reminder.dueDate.isBefore(DateTime.now()) && !reminder.isCompleted;
                      final daysDiff = _formatDate(reminder.dueDate);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border(
                            left: BorderSide(
                              color: reminder.isCompleted
                                  ? const Color(0xFF10B981)
                                  : isOverdue
                                      ? Colors.red
                                      : Colors.yellow,
                              width: 4,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            children: [
                              Text(
                                _getTypeIcon(reminder.type),
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            reminder.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: reminder.isCompleted
                                                  ? const Color(0xFF6B7280)
                                                  : const Color(0xFF111827),
                                              decoration: reminder.isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => _toggleCompleted(reminder.id),
                                          child: Icon(
                                            reminder.isCompleted
                                                ? LucideIcons.checkCircle
                                                : LucideIcons.circle,
                                            color: reminder.isCompleted
                                                ? const Color(0xFF10B981)
                                                : const Color(0xFF9CA3AF),
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.clock,
                                          color: isOverdue && !reminder.isCompleted
                                              ? Colors.red
                                              : const Color(0xFF6B7280),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          daysDiff,
                                          style: TextStyle(
                                            color: isOverdue && !reminder.isCompleted
                                                ? Colors.red
                                                : const Color(0xFF6B7280),
                                            fontSize: 12,
                                            fontWeight: isOverdue && !reminder.isCompleted
                                                ? FontWeight.w500
                                                : FontWeight.normal,
                                          ),
                                        ),
                                        if (reminder.amount > 0) ...[
                                          const SizedBox(width: 16),
                                          const Icon(
                                            LucideIcons.bell,
                                            color: Color(0xFF6B7280),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '৳${reminder.amount.toString()}',
                                            style: const TextStyle(
                                              color: Color(0xFF6B7280),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    if (!reminder.isCompleted) ...[
                                      const SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: () => _toggleCompleted(reminder.id),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6366F1).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Mark as Done',
                                            style: TextStyle(
                                              color: Color(0xFF6366F1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentRoute: '/reminders'),
    );
  }
}
