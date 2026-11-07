import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import '../resources/textplaceholder.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'browse_plant_screen.dart'; 
import 'browse_tips_screen.dart'; 
import '../screens/welcome_screen.dart';

class GuestHomeScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess; 

  const GuestHomeScreen({super.key, required this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // ✅ Top Row with App Name and Login Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextPlaceholders.appName, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryText, fontFamily: 'serif')),
                    Text(TextPlaceholders.appTagline, style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // ✅ PUSH to Login Screen
                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen(onLoginSuccess: onLoginSuccess)));
                  },
                  child: const Text("Login", style: TextStyle(color: AppColors.buttonColor, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            Text(TextPlaceholders.greeting, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 16),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.lightGreenCard, borderRadius: BorderRadius.circular(16)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("✔️ ${TextPlaceholders.infoCardTitle}", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryText, fontSize: 15)),
                  SizedBox(height: 6),
                  Text(TextPlaceholders.infoCardSubtitle, style: TextStyle(color: AppColors.primaryText, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(TextPlaceholders.suggestionTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                GestureDetector(
                  // ✅ PUSH to Browse Plant Screen
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrowsePlantScreen())), 
                  child: Text(TextPlaceholders.seeAll, style: TextStyle(color: AppColors.buttonColor, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildPlantCard("Aloe Vera", 'assets/images/aloe_vera.jpg')),
                const SizedBox(width: 16),
                Expanded(child: _buildPlantCard("Snake Plant", 'assets/images/snake_plant.jpg')),
              ],
            ),
            const SizedBox(height: 28),
            const Text(TextPlaceholders.careTipsTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
            const SizedBox(height: 16),
            ElevatedButton(
              // ✅ PUSH to Browse Tips Screen
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrowseTipsScreen())), 
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGreenCard, elevation: 0, padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                foregroundColor: Colors.black87, minimumSize: const Size(double.infinity, 0),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.water_drop, color: AppColors.buttonColor, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextPlaceholders.careTipTitle, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryText, fontSize: 15)),
                        SizedBox(height: 6),
                        Text(TextPlaceholders.careTipDesc, style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(onSignupSuccess: onLoginSuccess)));
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(TextPlaceholders.guestHomeCreateAccountBtn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 2),
              ),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }

  Widget _buildPlantCard(String name, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(imagePath, height: 90, width: 90, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.eco, size: 50, color: Colors.grey)),
          ),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 15)),
        ],
      ),
    );
  }
}