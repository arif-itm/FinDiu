import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navigation.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spendingData = [
      {'category': 'Food', 'amount': 2800, 'percentage': 35, 'color': Colors.orange},
      {'category': 'Transport', 'amount': 1500, 'percentage': 19, 'color': Colors.blue},
      {'category': 'Education', 'amount': 1200, 'percentage': 15, 'color': Colors.purple},
      {'category': 'Entertainment', 'amount': 1000, 'percentage': 12, 'color': Colors.pink},
      {'category': 'Shopping', 'amount': 800, 'percentage': 10, 'color': Colors.green},
      {'category': 'Others', 'amount': 700, 'percentage': 9, 'color': Colors.grey},
    ];

    final monthlyTrend = [
      {'month': 'Oct', 'amount': 6800},
      {'month': 'Nov', 'amount': 7200},
      {'month': 'Dec', 'amount': 6900},
      {'month': 'Jan', 'amount': 8000},
    ];

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
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
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
                                SizedBox(height: 8),
                                Text(
                                  '৳8,000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '+12% from last month',
                                  style: TextStyle(
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
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      LucideIcons.trendingDown,
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
                                SizedBox(height: 8),
                                Text(
                                  '৳258',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '-5% from last month',
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
              transform: Matrix4.translationValues(0, -24, 0),
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
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    LucideIcons.trendingUp,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Food spending increased',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF111827),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'You spent 15% more on food this month. Consider meal planning to reduce costs.',
                                        style: TextStyle(
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
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    LucideIcons.trendingDown,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Great job on transport!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF111827),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'You saved ৳300 on transport this month by using your student bus pass.',
                                        style: TextStyle(
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
  }
}
