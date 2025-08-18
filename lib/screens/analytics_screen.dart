import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_navigation.dart';
import '../providers/transaction_provider.dart';
import '../providers/auth_provider.dart';
import '../models/transaction.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize transactions when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
      
      if (authProvider.isAuthenticated && authProvider.user != null) {
        transactionProvider.initializeTransactions(authProvider.user!.uid);
      }
    });
  }

  List<Map<String, dynamic>> _getSpendingData(Map<String, double> categoryTotals, double totalExpenses) {
    final categoryColors = {
      'Campus Food': Colors.orange,
      'Food': Colors.orange,
      'Transport': Colors.blue,
      'Education': Colors.purple,
      'Tuition': Colors.purple,
      'Entertainment': Colors.pink,
      'Shopping': Colors.green,
      'Books': Colors.teal,
      'Utilities': Colors.red,
      'Health': Colors.pink.shade300,
      'Others': Colors.grey,
      'Other': Colors.grey,
    };

    return categoryTotals.entries
        .where((entry) => entry.value > 0)
        .map((entry) {
          final percentage = totalExpenses > 0 ? (entry.value / totalExpenses * 100).round() : 0;
          return {
            'category': entry.key,
            'amount': entry.value.round(),
            'percentage': percentage,
            'color': categoryColors[entry.key] ?? Colors.grey,
          };
        })
        .toList()
      ..sort((a, b) => (b['amount'] as int).compareTo(a['amount'] as int));
  }

  List<Map<String, dynamic>> _getMonthlyTrend(List<Transaction> transactions) {
    final now = DateTime.now();
    final monthlyData = <String, double>{};
    
    // Get last 4 months including current
    for (int i = 3; i >= 0; i--) {
      final monthDate = DateTime(now.year, now.month - i, 1);
      final monthName = _getMonthName(monthDate.month);
      
      final monthStart = DateTime(monthDate.year, monthDate.month, 1);
      final monthEnd = DateTime(monthDate.year, monthDate.month + 1, 0);
      
      final monthExpenses = transactions
          .where((t) => 
              t.type == TransactionType.expense &&
              t.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
              t.date.isBefore(monthEnd.add(const Duration(days: 1))))
          .fold(0.0, (sum, t) => sum + t.amount);
      
      monthlyData['$monthName'] = monthExpenses;
    }
    
    return monthlyData.entries
        .map((entry) => {
              'month': entry.key,
              'amount': entry.value.round(),
            })
        .toList();
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  List<Map<String, dynamic>> _generateInsights(
    Map<String, double> categoryTotals, 
    double monthlyChange, 
    double totalExpenses,
    List<Transaction> transactions
  ) {
    final insights = <Map<String, dynamic>>[];
    
    // Check if there's spending data
    if (categoryTotals.isEmpty || totalExpenses == 0) {
      insights.add({
        'title': 'Start tracking your expenses',
        'description': 'Add some transactions to see personalized insights about your spending patterns.',
        'color': Colors.blue,
        'icon': LucideIcons.info,
      });
      return insights;
    }

    // Top spending category insight
    if (categoryTotals.isNotEmpty) {
      final topCategory = categoryTotals.entries
          .reduce((a, b) => a.value > b.value ? a : b);
      
      final percentage = (topCategory.value / totalExpenses * 100).round();
      
      insights.add({
        'title': '${topCategory.key} is your top expense',
        'description': 'You spent ৳${topCategory.value.round()} (${percentage}%) on ${topCategory.key} this month.',
        'color': percentage > 40 ? Colors.orange : Colors.blue,
        'icon': percentage > 40 ? LucideIcons.alertTriangle : LucideIcons.pieChart,
      });
    }

    // Monthly trend insight
    if (monthlyChange != 0) {
      if (monthlyChange > 10) {
        insights.add({
          'title': 'Spending increased significantly',
          'description': 'Your expenses increased by ${monthlyChange}% this month. Consider reviewing your budget.',
          'color': Colors.red,
          'icon': LucideIcons.trendingUp,
        });
      } else if (monthlyChange < -10) {
        insights.add({
          'title': 'Great job saving money!',
          'description': 'You reduced your expenses by ${monthlyChange.abs()}% this month. Keep it up!',
          'color': Colors.green,
          'icon': LucideIcons.trendingDown,
        });
      }
    }

    // If no significant insights, add a general one
    if (insights.length == 1) {
      final avgDailySpending = (totalExpenses / DateTime.now().day).round();
      insights.add({
        'title': 'Steady spending pattern',
        'description': 'You\'re spending an average of ৳${avgDailySpending} per day this month.',
        'color': Colors.green,
        'icon': LucideIcons.checkCircle,
      });
    }

    return insights.take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        final categoryTotals = transactionProvider.getExpenseCategories();
        final totalExpenses = transactionProvider.monthlyExpenses;
        final dailyAverage = totalExpenses > 0 ? (totalExpenses / DateTime.now().day).round() : 0;
        final spendingData = _getSpendingData(categoryTotals, totalExpenses);
        final monthlyTrend = _getMonthlyTrend(transactionProvider.transactions);
        
        // Calculate previous month expenses for comparison
        final now = DateTime.now();
        final lastMonthStart = DateTime(now.year, now.month - 1, 1);
        final lastMonthEnd = DateTime(now.year, now.month, 0);
        final lastMonthExpenses = transactionProvider.getTransactionsByDateRange(lastMonthStart, lastMonthEnd)
            .where((t) => t.type == TransactionType.expense)
            .fold(0.0, (sum, t) => sum + t.amount);
        
        final monthlyChange = lastMonthExpenses > 0 
            ? ((totalExpenses - lastMonthExpenses) / lastMonthExpenses * 100).round()
            : 0;
            
        final insights = _generateInsights(categoryTotals, monthlyChange.toDouble(), totalExpenses, transactionProvider.transactions);

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
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
                          'Analytics',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      LucideIcons.trendingUp,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'This Month',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '৳${totalExpenses.round().toString()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  monthlyChange >= 0 
                                      ? '+${monthlyChange}% from last month' 
                                      : '${monthlyChange}% from last month',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      LucideIcons.calendar,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Daily Average',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '৳${dailyAverage}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Based on this month',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                child: Column(
                  children: [
                    // Spending by Category
                    Container(
                      padding: const EdgeInsets.all(24),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                LucideIcons.pieChart,
                                color: Color(0xFF6366F1),
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Spending by Category',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          if (spendingData.isEmpty)
                            Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Icon(
                                    LucideIcons.pieChart,
                                    size: 48,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'No spending data yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Start adding your expenses to see spending breakdown by category.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            ...spendingData.map((item) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: item['color'] as Color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        item['category'] as String,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF111827),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '৳${(item['amount'] as int).toString()}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF111827),
                                        ),
                                      ),
                                      Text(
                                        '${item['percentage']}%',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 8,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5E7EB),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: ((item['percentage'] as int).clamp(0, 100)) / 100.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: item['color'] as Color,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Monthly Trend
                    Container(
                      padding: const EdgeInsets.all(24),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                LucideIcons.barChart3,
                                color: Color(0xFF6366F1),
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Monthly Spending Trend',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          if (monthlyTrend.isEmpty || monthlyTrend.every((item) => item['amount'] == 0))
                            Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Icon(
                                    LucideIcons.barChart3,
                                    size: 48,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'No trend data yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Add transactions over time to see your monthly spending trends.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            ...monthlyTrend.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            final maxAmount = monthlyTrend.map((d) => d['amount'] as int).reduce((a, b) => a > b ? a : b);
                            final percentage = maxAmount > 0 ? ((item['amount'] as int) / maxAmount) * 100 : 0.0;
                            final isIncrease = index > 0 && (item['amount'] as int) > (monthlyTrend[index - 1]['amount'] as int);

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item['month']} 2024',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '৳${(item['amount'] as int).toString()}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                        if (index > 0) ...[
                                          const SizedBox(width: 8),
                                          Icon(
                                            isIncrease ? LucideIcons.trendingUp : LucideIcons.trendingDown,
                                            color: isIncrease ? Colors.red : const Color(0xFF10B981),
                                            size: 16,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 12,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E7EB),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (percentage.clamp(0.0, 100.0)) / 100.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Insights
                    Container(
                      padding: const EdgeInsets.all(24),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Insights',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...insights.map((insight) => Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: (insight['color'] as Color).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: insight['color'] as Color,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        insight['icon'] as IconData,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            insight['title'] as String,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF111827),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            insight['description'] as String,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6B7280),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (insights.indexOf(insight) < insights.length - 1)
                                const SizedBox(height: 16),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentRoute: '/analytics'),
    );
      },
    );
  }
}
