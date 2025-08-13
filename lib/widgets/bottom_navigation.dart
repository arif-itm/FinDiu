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
      {'route': '/add-expense', 'icon': LucideIcons.plusCircle, 'label': 'Add'},
      {'route': '/savings', 'icon': LucideIcons.target, 'label': 'Goals'},
      {'route': '/ai-chat', 'icon': LucideIcons.messageCircle, 'label': 'AI Chat'},
      {'route': '/analytics', 'icon': LucideIcons.barChart3, 'label': 'Analytics'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.map((item) {
              final isActive = currentRoute == item['route'];
              return GestureDetector(
                onTap: () => context.go(item['route'] as String),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: isActive
                          ? const Color(0xFF6366F1)
                          : const Color(0xFF9CA3AF),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? const Color(0xFF6366F1)
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
