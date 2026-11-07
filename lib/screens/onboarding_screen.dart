import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import '../resources/textplaceholder.dart';
import 'welcome_screen.dart'; 

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const OnboardingScreen({
    super.key, 
    required this.onLoginSuccess,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _bgImages = [
    'assets/images/bg1.png',
    'assets/images/bg2.png',
    'assets/images/bg3.png',
  ];

  final List<String> _descriptions = [
    TextPlaceholders.onboardingDesc1,
    TextPlaceholders.onboardingDesc2,
    TextPlaceholders.onboardingDesc3,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _descriptions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _goToWelcomeScreen();
    }
  }

  void _skip() {
    _goToWelcomeScreen();
  }

  void _goToWelcomeScreen() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(
            onLoginSuccess: widget.onLoginSuccess,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _descriptions.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final isLastPage = index == _descriptions.length - 1;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(_bgImages[index], fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: AppColors.onboardingBackground)),
              ),
              if (!isLastPage)
                Positioned(
                  top: 50, right: 20,
                  child: GestureDetector(
                    onTap: _skip,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.buttonColor, borderRadius: BorderRadius.circular(20)),
                      child: const Text("Skip", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Column(
                      children: [
                        Text(TextPlaceholders.appName, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryText, fontFamily: 'serif')),
                        SizedBox(height: 5),
                        Text(TextPlaceholders.appTagline, style: TextStyle(fontSize: 16, color: AppColors.primaryText, fontFamily: 'serif')),
                      ],
                    ),
                    const Spacer(),
                    Text(_descriptions[index], textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: AppColors.primaryText, height: 1.5, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    if (isLastPage)
                      SizedBox(
                        width: double.infinity, height: 55,
                        child: ElevatedButton(
                          onPressed: _goToWelcomeScreen,
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                          child: const Text("Get Started", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _nextPage,
                            child: const Row(children: [Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)), SizedBox(width: 5), Icon(Icons.arrow_forward, size: 20, color: AppColors.primaryText)]),
                          ),
                          Row(
                            children: List.generate(_descriptions.length, (dotIndex) => Container(margin: const EdgeInsets.symmetric(horizontal: 4), width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: dotIndex == index ? AppColors.dotActive : AppColors.dotInactive))),
                          ),
                        ],
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}