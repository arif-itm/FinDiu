import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/add_expense_screen.dart';
import '../screens/savings_screen.dart';
import '../screens/reminders_screen.dart';
import '../screens/ai_chat_screen.dart';
import '../screens/analytics_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/profile_edit_screen.dart';
import '../screens/about_screen.dart';
import '../screens/transactions_screen.dart';
import '../providers/auth_provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  refreshListenable: null, // Will be set up in main.dart
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isAuthenticated = authProvider.isAuthenticated;
    final isLoading = authProvider.isLoading;
    
    // If still loading, stay on current route
    if (isLoading) return null;
    
    // Public routes that don't require authentication
    final publicRoutes = ['/splash', '/login', '/signup'];
    final isPublicRoute = publicRoutes.contains(state.matchedLocation);
    
    // If not authenticated and trying to access protected route
    if (!isAuthenticated && !isPublicRoute) {
      return '/login';
    }
    
    // If authenticated and on auth routes, redirect to dashboard
    if (isAuthenticated && (state.matchedLocation == '/login' || state.matchedLocation == '/signup')) {
      return '/dashboard';
    }
    
    return null; // No redirect needed
  },
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/add-expense',
      name: 'add-expense',
      builder: (context, state) => AddExpenseScreen(),
    ),
    GoRoute(
      path: '/savings',
      name: 'savings',
      builder: (context, state) => const SavingsScreen(),
    ),
    GoRoute(
      path: '/reminders',
      name: 'reminders',
      builder: (context, state) => const RemindersScreen(),
    ),
    GoRoute(
      path: '/ai-chat',
      name: 'ai-chat',
      builder: (context, state) => const AIChatScreen(),
    ),
    GoRoute(
      path: '/analytics',
      name: 'analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/profile-edit',
      name: 'profile-edit',
      builder: (context, state) => ProfileEditScreen(),
    ),
    GoRoute(
      path: '/about',
      name: 'about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/transactions',
      name: 'transactions',
      builder: (context, state) => const TransactionsScreen(),
    ),
  ],
);
