import 'package:flutter/material.dart';
import '../../resources/colors_resource.dart';
import '../../resources/textplaceholder.dart';
import 'login_screen.dart'; // ✅ Import LoginScreen for redirection

class SignupScreen extends StatefulWidget {
  final VoidCallback onSignupSuccess;

  const SignupScreen({
    super.key, 
    required this.onSignupSuccess,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                TextPlaceholders.signupTitle, 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryText)
              ),
              const SizedBox(height: 8),
              const Text(
                TextPlaceholders.signupSubtitle, 
                style: TextStyle(fontSize: 14, color: Colors.black54)
              ),
              const SizedBox(height: 32),
              
              _buildInputField(TextPlaceholders.fullNameHint, Icons.person_outline),
              const SizedBox(height: 16),
              _buildInputField(TextPlaceholders.emailHint, Icons.email_outlined),
              const SizedBox(height: 16),
              _buildInputField(TextPlaceholders.passwordHint, Icons.lock_outline, isPassword: true),
              const SizedBox(height: 16),
              _buildInputField(TextPlaceholders.confirmPasswordHint, Icons.lock_outline, isPassword: true),
              const SizedBox(height: 32),
              
              // ✅ UPDATED REGISTER BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // 1. Display the success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Account created successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    
                    // 2. Trigger the callback to switch to User Navigation in main.dart
                    widget.onSignupSuccess();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 
                    elevation: 0
                  ),
                  // ✅ Button always says "Register" / "Create Account"
                  child: Text(
                    TextPlaceholders.createAccountBtn, 
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    TextPlaceholders.alreadyHaveAccount, 
                    style: TextStyle(color: Colors.black54, fontSize: 14)
                  ),
                  TextButton(
                    onPressed: () {
                      // ✅ Redirect to Login Screen and pass the success callback
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(onLoginSuccess: widget.onSignupSuccess),
                        ),
                      );
                    },
                    child: const Text(
                      TextPlaceholders.loginLink, 
                      style: TextStyle(color: AppColors.buttonColor, fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, IconData icon, {bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(12), 
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hint, 
                hintStyle: const TextStyle(color: Colors.grey), 
                border: InputBorder.none, 
                contentPadding: const EdgeInsets.symmetric(vertical: 16)
              ),
            ),
          ),
        ],
      ),
    );
  }
}