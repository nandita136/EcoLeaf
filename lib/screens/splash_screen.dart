import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import '../resources/textplaceholder.dart';
import 'onboarding_screen.dart'; 

class SplashScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const SplashScreen({
    super.key, 
    required this.onLoginSuccess,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); 
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(
            onLoginSuccess: widget.onLoginSuccess,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.splashTopGreen, AppColors.splashBottomGreen]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 110, width: 110,
                decoration: const BoxDecoration(color: AppColors.logoBackground, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))]),
                child: const Icon(Icons.spa, size: 60, color: AppColors.logoIconGreen),
              ),
              const SizedBox(height: 20),
              const Text(TextPlaceholders.appName, style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: AppColors.textWhite, fontFamily: 'serif', letterSpacing: 1.2)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(24, (index) => Container(width: 4, height: 4, margin: const EdgeInsets.symmetric(horizontal: 3), decoration: const BoxDecoration(color: AppColors.textWhite, shape: BoxShape.circle))),
              ),
              const SizedBox(height: 15),
              const Text(TextPlaceholders.appTagline, style: TextStyle(fontSize: 16, color: AppColors.textWhite, fontFamily: 'serif', letterSpacing: 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}