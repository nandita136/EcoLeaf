import 'package:flutter/material.dart';
import '../../resources/colors_resource.dart';
import 'user_plant_info_screen.dart'; // Import the details screen

// Simple Plant Model for this screen
class ExplorePlant {
  final String name;
  final String category;
  final String imagePath;
  final String light;
  final String water;
  final String temp;

  ExplorePlant({
    required this.name,
    required this.category,
    required this.imagePath,
    required this.light,
    required this.water,
    required this.temp,
  });
}

class UserExplorePlantsScreen extends StatefulWidget {
  final Function(ExplorePlant plant) onAddToGarden;

  const UserExplorePlantsScreen({super.key, required this.onAddToGarden});

  @override
  State<UserExplorePlantsScreen> createState() => _UserExplorePlantsScreenState();
}

class _UserExplorePlantsScreenState extends State<UserExplorePlantsScreen> {
  // ✅ Removed _selectedFilter and _filters

  // Mock Data matching your screenshot
  final List<ExplorePlant> _plants = [
    ExplorePlant(name: 'Snake Plant', category: 'Air Purifying', imagePath: 'assets/images/snake_plant.jpg', light: 'Low to Bright', water: '2-6 Weeks', temp: '15°C - 30°C'),
    ExplorePlant(name: 'Money Plant', category: 'Air Purifying', imagePath: 'assets/images/money_plant.jpg', light: 'Bright Indirect', water: '7-10 Days', temp: '18°C - 30°C'),
    ExplorePlant(name: 'Peace Lily', category: 'Flowering', imagePath: 'assets/images/peace_lily.jpg', light: 'Low Light', water: '1-2 Weeks', temp: '18°C - 26°C'),
    ExplorePlant(name: 'Cactus Plant', category: 'Succulent', imagePath: 'assets/images/cactus_trio.jpg', light: 'Direct Sun', water: '3-4 Weeks', temp: '20°C - 35°C'),
    ExplorePlant(name: 'Bougainvillea', category: 'Flowering', imagePath: 'assets/images/bougainvillea.jpg', light: 'Full Sun', water: '1-2 Weeks', temp: '20°C - 35°C'),
    ExplorePlant(name: 'Calathea', category: 'Decorative', imagePath: 'assets/images/calathea_plant.jpg', light: 'Indirect Light', water: '1 Week', temp: '18°C - 24°C'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Explore Plants", style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Header & Search (✅ Filters Removed)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Explore plants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]),
                    child: const Row(children: [Icon(Icons.search, color: Colors.grey, size: 20), SizedBox(width: 10), Expanded(child: TextField(decoration: InputDecoration(hintText: 'Search plant...', border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey))))]),
                  ),
                  // ✅ Removed the filters section (SizedBox and ListView)
                ],
              ),
            ),
          ),

          // Plant Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.75),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final plant = _plants[index];
                  return _buildPlantCard(plant);
                },
                childCount: _plants.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildPlantCard(ExplorePlant plant) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 100, width: double.infinity, color: const Color(0xFFE0E0E0),
              child: Image.asset(plant.imagePath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.eco, size: 40, color: Colors.grey)),
            ),
          ),
          const SizedBox(height: 10),
          Text(plant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primaryText), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(plant.category, style: const TextStyle(fontSize: 11, color: Colors.black54)),
          const Spacer(),
          SizedBox(
            width: double.infinity, height: 32,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserPlantInfoScreen(
                      plant: plant,
                      onAddToGarden: () => widget.onAddToGarden(plant),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: EdgeInsets.zero),
              child: const Text("View Details →", style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}