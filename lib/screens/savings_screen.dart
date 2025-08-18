import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_navigation.dart';
import '../models/savings_goal.dart';
import '../utils/input_validators.dart';
import '../providers/savings_goal_provider.dart';
import '../providers/auth_provider.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  bool _showCreateModal = false;
  bool _showAddMoneyModal = false;
  String _selectedGoalId = '';
  final TextEditingController _addAmountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _targetAmountController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  String _selectedCategory = 'Education';

  @override
  void initState() {
    super.initState();
    // Initialize savings goals when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final savingsProvider = Provider.of<SavingsGoalProvider>(context, listen: false);
      
      if (authProvider.isAuthenticated && authProvider.user != null) {
        savingsProvider.initializeSavingsGoals(authProvider.user!.uid);
      }
    });
  }

  final List<Map<String, dynamic>> categories = [
    {'name': 'Education', 'color': Colors.blue},
    {'name': 'Technology', 'color': Colors.purple},
    {'name': 'Emergency', 'color': Colors.orange},
    {'name': 'Travel', 'color': Colors.green},
    {'name': 'Books', 'color': Colors.red},
    {'name': 'Other', 'color': Colors.grey},
  ];

  Future<void> _handleCreateGoal() async {
    if (_titleController.text.isNotEmpty && 
        _targetAmountController.text.isNotEmpty) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final savingsProvider = Provider.of<SavingsGoalProvider>(context, listen: false);
      
      if (authProvider.user != null) {
        final newGoal = SavingsGoal(
          id: '', // Firestore will generate the ID
          title: _titleController.text,
          targetAmount: double.parse(_targetAmountController.text),
          currentAmount: 0.0,
          deadline: DateTime.now().add(const Duration(days: 90)),
          category: _selectedCategory,
          color: categories.firstWhere((cat) => cat['name'] == _selectedCategory)['color'],
        );

        await savingsProvider.addSavingsGoal(newGoal, authProvider.user!.uid);

        setState(() {
          _showCreateModal = false;
        });

        _titleController.clear();
        _targetAmountController.clear();
      }
    }
  }

  Future<void> _handleAddMoney() async {
    if (_addAmountController.text.isNotEmpty && _selectedGoalId.isNotEmpty) {
      final amount = double.parse(_addAmountController.text);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final savingsProvider = Provider.of<SavingsGoalProvider>(context, listen: false);
      
      if (authProvider.user != null) {
        await savingsProvider.addMoneyToGoal(_selectedGoalId, amount, authProvider.user!.uid);
        
        setState(() {
          _showAddMoneyModal = false;
          _addAmountController.clear();
          _selectedGoalId = '';
        });
      }
    }
  }

  int _getDaysLeft(DateTime deadline) {
    return deadline.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SavingsGoalProvider, AuthProvider>(
      builder: (context, savingsProvider, authProvider, child) {
        final savingsGoals = savingsProvider.savingsGoals;
        final totalSaved = savingsProvider.totalSaved.toInt();
        final isLoading = savingsProvider.isLoading;
        final error = savingsProvider.error;
        
        if (!authProvider.isAuthenticated) {
          return const Scaffold(
            body: Center(
              child: Text('Please log in to view savings goals'),
            ),
            bottomNavigationBar: BottomNavigation(currentRoute: '/savings'),
          );
        }
        
        if (isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
            bottomNavigationBar: BottomNavigation(currentRoute: '/savings'),
          );
        }
        
        if (error != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (authProvider.user != null) {
                        savingsProvider.initializeSavingsGoals(authProvider.user!.uid);
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const BottomNavigation(currentRoute: '/savings'),
          );
        }
        
        return Scaffold(
          body: Stack(
            children: [
              Column(
            children: [
              // Header
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
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
                              'Savings Goals',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Total Savings
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Total Saved',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '৳${totalSaved.toString()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    LucideIcons.trendingUp,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '+12% this month',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                    child: Column(
                      children: [
                        // Add New Goal Button
                        GestureDetector(
                          onTap: () => setState(() => _showCreateModal = true),
                          child: Container(
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
                                      colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
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
                                      'Create New Goal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    Text(
                                      'Start saving for something special',
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
                        ),
                        const SizedBox(height: 24),
                        // Savings Goals
                        if (savingsGoals.isEmpty)
                          Container(
                            padding: const EdgeInsets.all(48),
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
                            child: const Column(
                              children: [
                                Icon(
                                  LucideIcons.target,
                                  size: 64,
                                  color: Color(0xFF9CA3AF),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No savings goals yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Start by creating your first savings goal',
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        else
                          ...savingsGoals.map((goal) {
                          final progress = goal.targetAmount > 0 
                            ? (goal.currentAmount / goal.targetAmount) * 100 
                            : 0.0;
                          final daysLeft = _getDaysLeft(goal.deadline);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
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
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: goal.color,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                        LucideIcons.target,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            goal.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF111827),
                                            ),
                                          ),
                                          Text(
                                            goal.category,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6B7280),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '$daysLeft days left',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Progress
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Progress',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                    Text(
                                      '${progress.toInt()}%',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                    widthFactor: (progress.clamp(0.0, 100.0)) / 100.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: goal.color,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Amounts
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Saved',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                        Text(
                                          '৳${goal.currentAmount.toInt().toString()}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Target',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                        Text(
                                          '৳${goal.targetAmount.toInt().toString()}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Add Money Button
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedGoalId = goal.id;
                                      _showAddMoneyModal = true;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '৳',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Add Money',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
          // Create Goal Modal
          if (_showCreateModal)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Create New Goal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _showCreateModal = false),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                LucideIcons.x,
                                size: 16,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Goal Title',
                          hintText: 'e.g., New Laptop, Study Abroad',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _targetAmountController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: InputValidators.getAmountFormatters(),
                        onChanged: (value) {
                          setState(() {}); // Trigger rebuild for validation
                        },
                        decoration: InputDecoration(
                          labelText: 'Target Amount',
                          hintText: '0',
                          prefixText: '৳',
                          errorText: InputValidators.getAmountErrorMessage(_targetAmountController.text),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category['name'],
                            child: Text(category['name']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => setState(() => _showCreateModal = false),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (_titleController.text.isNotEmpty &&
                                       _targetAmountController.text.isNotEmpty &&
                                       _selectedCategory.isNotEmpty &&
                                       InputValidators.isValidAmount(_targetAmountController.text))
                                  ? _handleCreateGoal
                                  : null,
                              child: const Text('Create Goal'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Add Money Modal
          if (_showAddMoneyModal)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add Money',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _showAddMoneyModal = false),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                LucideIcons.x,
                                size: 16,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _addAmountController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: InputValidators.getAmountFormatters(),
                        onChanged: (value) {
                          setState(() {}); // Trigger rebuild for validation
                        },
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: '0',
                          prefixText: '৳',
                          errorText: InputValidators.getAmountErrorMessage(_addAmountController.text),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => setState(() => _showAddMoneyModal = false),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (_addAmountController.text.isNotEmpty &&
                                       InputValidators.isValidAmount(_addAmountController.text))
                                  ? _handleAddMoney
                                  : null,
                              child: const Text('Add Money'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentRoute: '/savings'),
    );
      },
    );
  }

  @override
  void dispose() {
    _addAmountController.dispose();
    _titleController.dispose();
    _targetAmountController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }
}
