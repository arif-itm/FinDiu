import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../utils/input_validators.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _universityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _universityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showErrorSnackBar('Please fill in all fields');
      return;
    }
    
    if (!email.contains('@') || !email.contains('.')) {
      _showErrorSnackBar('Please enter a valid email address');
      return;
    }
    
    if (password != confirmPassword) {
      _showErrorSnackBar('Passwords do not match');
      return;
    }
    
    if (password.length < 6) {
      _showErrorSnackBar('Password must be at least 6 characters');
      return;
    }
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.registerWithEmailPassword(email, password, name);
    
    if (success) {
      context.go('/dashboard');
    } else {
      _showErrorSnackBar(authProvider.errorMessage ?? 'Registration failed');
    }
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF1F5F9), // Secondary-50
              Color(0xFFF8FAFC), // Primary-50
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Column(
                    children: [
                      const Text(
                        'Join FinDiu',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create your student banking account',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Form Fields
                  Column(
                    children: [
                      // Full Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Icon(LucideIcons.user),
                        ),
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        inputFormatters: InputValidators.getEmailFormatters(),
                        onChanged: (value) {
                          setState(() {}); // Trigger rebuild for validation
                        },
                        decoration: InputDecoration(
                          hintText: 'University email (e.g., student@diu.edu.bd)',
                          prefixIcon: Icon(LucideIcons.mail),
                          errorText: InputValidators.getDiuEmailErrorMessage(_emailController.text),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Student ID Field
                      TextFormField(
                        controller: _studentIdController,
                        keyboardType: TextInputType.number,
                        inputFormatters: InputValidators.getStudentIdFormatters(),
                        decoration: const InputDecoration(
                          hintText: 'Student ID',
                          prefixIcon: Icon(LucideIcons.graduationCap),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // University Field
                      TextFormField(
                        controller: _universityController,
                        decoration: const InputDecoration(
                          hintText: 'University',
                          prefixIcon: Icon(LucideIcons.building),
                        ),
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(LucideIcons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword ? LucideIcons.eyeOff : LucideIcons.eye,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_showConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(LucideIcons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showConfirmPassword ? LucideIcons.eyeOff : LucideIcons.eye,
                            ),
                            onPressed: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        child: Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return ElevatedButton(
                              onPressed: authProvider.isLoading ? null : _handleSignup,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B5CF6), // Secondary-500
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: authProvider.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Create Account',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(LucideIcons.arrowRight, size: 20),
                                      ],
                                    ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Sign In Link
                      Container(
                        padding: const EdgeInsets.only(top: 24),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFFE5E7EB)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            GestureDetector(
                              onTap: () => context.go('/login'),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
