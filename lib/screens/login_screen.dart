import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import '../resources/textplaceholder.dart';
import 'signup_screen.dart';
import 'guest_home_screen.dart';
import 'forgot_password_screen.dart';
import 'user_plant_manager.dart'; // ✅ Imports the manager with 20 plants
import 'welcome_screen.dart';     // ✅ Needed for logout navigation

class LoginScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess; 

  const LoginScreen({super.key, required this.onLoginSuccess});

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
                TextPlaceholders.loginTitle, 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryText)
              ),
              const SizedBox(height: 8),
              const Text(
                TextPlaceholders.loginSubtitle, 
                style: TextStyle(fontSize: 14, color: Colors.black54)
              ),
              const SizedBox(height: 32),

              _buildInputField(TextPlaceholders.emailHint, Icons.email_outlined),
              const SizedBox(height: 16),
              _buildInputField(TextPlaceholders.passwordHint, Icons.lock_outline, isPassword: true),
              
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  }, 
                  child: const Text(
                    TextPlaceholders.forgotPassword, 
                    style: TextStyle(color: AppColors.buttonColor, fontSize: 13)
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ✅ FOOLPROOF LOGIN BUTTON: Navigates directly to UserPlantManager
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPlantManager(
                          onLogout: () {
                            // When they logout, clear everything and go back to Welcome
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(
                                  onLoginSuccess: () {}, // Dummy callback, state is handled by pushAndRemoveUntil
                                ),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ),
                      (route) => false, // Clears Login/Welcome from back-stack
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              _buildOrDivider(),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => SignupScreen(onSignupSuccess: onLoginSuccess))
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Create New Account",
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              _buildOrDivider(),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => GuestHomeScreen(onLoginSuccess: onLoginSuccess)),
                      (route) => route.isFirst, 
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Continue as Guest",
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                ),
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
              )
            )
          )
        ]
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.grey)), 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), 
          child: Text(
            TextPlaceholders.orText, 
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12)
          )
        ), 
        const Expanded(child: Divider(color: Colors.grey))
      ]
    );
  }
}