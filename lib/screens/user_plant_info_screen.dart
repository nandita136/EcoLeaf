import 'package:flutter/material.dart';
import '../../resources/colors_resource.dart';
import 'user_explore_plants_screen.dart'; // Import the model

class UserPlantInfoScreen extends StatelessWidget {
  final ExplorePlant plant;
  final VoidCallback onAddToGarden;

  const UserPlantInfoScreen({super.key, required this.plant, required this.onAddToGarden});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText, size: 20), onPressed: () => Navigator.pop(context)),
        title: const Text('Plant Info', style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 250, width: double.infinity, color: const Color(0xFFE0E0E0),
              child: Image.asset(plant.imagePath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.eco, size: 60, color: Colors.grey))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plant.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  const SizedBox(height: 4),
                  Row(children: [Icon(Icons.eco, size: 14, color: Colors.black54), const SizedBox(width: 4), Text(plant.category, style: const TextStyle(fontSize: 14, color: Colors.black54))]),
                  const SizedBox(height: 16),
                  const Text('The Money Plant (Epipremnum aureum) is a highly resilient climber prized for its beautiful heart-shaped leaves marked in green and yellow. Perfect for beginners and busy gardeners.', style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5)),
                  const SizedBox(height: 24),
                  
                  const Text('Basic Care', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildCareCard(Icons.wb_sunny_outlined, 'LIGHT', plant.light, Colors.orange),
                      const SizedBox(width: 12),
                      _buildCareCard(Icons.water_drop_outlined, 'WATER', plant.water, Colors.blue),
                      const SizedBox(width: 12),
                      _buildCareCard(Icons.thermostat_outlined, 'TEMP', plant.temp, Colors.red),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Add Button
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        onAddToGarden();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to My Garden successfully!'), backgroundColor: AppColors.buttonColor));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_circle_outline, color: Colors.white, size: 20), SizedBox(width: 8), Text('Add plant to my garden', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))]),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareCard(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]),
        child: Column(children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryText), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}