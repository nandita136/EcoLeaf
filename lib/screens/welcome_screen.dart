import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import '../resources/textplaceholder.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'guest_home_screen.dart'; 

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess;

  const WelcomeScreen({
    super.key, 
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Column(
                children: [
                  Text(
                    TextPlaceholders.appName, 
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.primaryText, fontFamily: 'serif')
                  ),
                  SizedBox(height: 8),
                  Text(
                    TextPlaceholders.appTagline, 
                    style: TextStyle(fontSize: 16, color: AppColors.primaryText, fontFamily: 'serif')
                  ),
                ],
              ),
              const Spacer(),
              
             
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    print("🔥 BUTTON TAPPED: Continue as Guest");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuestHomeScreen(onLoginSuccess: onLoginSuccess),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), 
                    elevation: 2
                  ),
                  child: const Text(
                    "Continue as Guest", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
             
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    print("🔥 BUTTON TAPPED: Login");
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(onLoginSuccess: onLoginSuccess),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: AppColors.buttonColor)), 
                    elevation: 0
                  ),
                  child: Text(
                    TextPlaceholders.login, 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.buttonColor)
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.primaryText, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      TextPlaceholders.or, 
                      style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.primaryText, thickness: 1)),
                ],
              ),
              const SizedBox(height: 24),
              
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    print("🔥 BUTTON TAPPED: Create Account");
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(onSignupSuccess: onLoginSuccess),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), 
                    elevation: 2
                  ),
                  child: Text(
                    TextPlaceholders.createAccount, 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}