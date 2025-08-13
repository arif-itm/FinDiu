import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavigation extends StatelessWidget {
  final String currentRoute;

  const BottomNavigation({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'route': '/dashboard', 'icon': LucideIcons.home, 'label': 'Home'},
      {'route': '/savings', 'icon': LucideIcons.target, 'label': 'Goals'},
      {'route': '/add-expense', 'icon': LucideIcons.plus, 'label': 'Add', 'isSpecial': true},
      {'route': '/ai-chat', 'icon': LucideIcons.messageCircle, 'label': 'AI Chat'},
      {'route': '/analytics', 'icon': LucideIcons.barChart3, 'label': 'Analytics'},
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.map((item) {
              final isActive = currentRoute == item['route'];
              final isSpecial = item['isSpecial'] == true;
              
              if (isSpecial) {
                // Special prominent button for Add Expense
                return GestureDetector(
                  onTap: () => context.go(item['route'] as String),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isActive 
                            ? [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]
                            : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                );
              }
              
              // Regular navigation items
              return GestureDetector(
                onTap: () => context.go(item['route'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive 
                        ? const Color(0xFF6366F1).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: isActive
                            ? const Color(0xFF6366F1)
                            : const Color(0xFF9CA3AF),
                        size: 20,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                          color: isActive
                              ? const Color(0xFF6366F1)
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
