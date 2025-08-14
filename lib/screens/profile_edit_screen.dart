import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../utils/input_validators.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Md Ariful Islam');
  final TextEditingController _emailController = TextEditingController(text: 'arif-itm@diu.edu.bd');
  final TextEditingController _phoneController = TextEditingController(text: '+880 1700-123456');
  final TextEditingController _studentIdController = TextEditingController(text: '1234567890');
  final TextEditingController _universityController = TextEditingController(text: 'Daffodil International University');
  final TextEditingController _programController = TextEditingController(text: 'Information Technology & Management');
  final TextEditingController _addressController = TextEditingController(text: 'Dhaka, Bangladesh');
  
  String _selectedYear = '3rd Year';
  bool _showSuccess = false;

  final List<String> _years = [
    '1st Year',
    '2nd Year', 
    '3rd Year',
    '4th Year',
    'Masters',
    'PhD',
  ];

  void _handleSave() {
    setState(() {
      _showSuccess = true;
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        context.go('/profile');
      }
    });
  }

  void _handlePhotoChange() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Photo'),
        content: const Text('Photo change functionality would be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showSuccess) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.save,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Profile Updated!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your information has been saved successfully',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => context.go('/profile'),
                              icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _handleSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Profile Picture
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: -4,
                                right: -4,
                                child: GestureDetector(
                                  onTap: _handlePhotoChange,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to change photo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Personal Information
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _nameController,
                            icon: Icons.person,
                            hint: 'Full Name',
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _emailController,
                            icon: Icons.email,
                            hint: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _phoneController,
                            icon: Icons.phone,
                            hint: 'Phone Number',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _addressController,
                            icon: Icons.location_on,
                            hint: 'Address',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Academic Information
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Academic Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _studentIdController,
                            icon: Icons.school,
                            hint: 'Student ID',
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _universityController,
                            hint: 'University',
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _programController,
                            hint: 'Program/Major',
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedYear,
                            onChanged: (value) {
                              setState(() {
                                _selectedYear = value!;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE5E7EB),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            items: _years.map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_nameController.text.isNotEmpty &&
                                 _emailController.text.isNotEmpty &&
                                 _phoneController.text.isNotEmpty &&
                                 InputValidators.isValidDiuEmail(_emailController.text))
                            ? _handleSave
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    IconData? icon,
    required String hint,
    TextInputType? keyboardType,
  }) {
    // Determine input formatters based on field type
    List<TextInputFormatter>? inputFormatters;
    String? errorText;
    
    if (keyboardType == TextInputType.phone) {
      inputFormatters = InputValidators.getPhoneFormatters();
    } else if (hint.toLowerCase().contains('student id')) {
      inputFormatters = InputValidators.getStudentIdFormatters();
    } else if (keyboardType == TextInputType.emailAddress) {
      inputFormatters = InputValidators.getEmailFormatters();
      errorText = InputValidators.getDiuEmailErrorMessage(controller.text);
    }

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: keyboardType == TextInputType.emailAddress 
          ? (value) => setState(() {}) // Trigger rebuild for email validation
          : null,
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: const Color(0xFF9CA3AF),
              )
            : null,
        hintText: keyboardType == TextInputType.emailAddress 
            ? 'Email Address (e.g., student@diu.edu.bd)'
            : hint,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _studentIdController.dispose();
    _universityController.dispose();
    _programController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
