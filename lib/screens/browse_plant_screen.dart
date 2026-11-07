import 'package:flutter/material.dart';
import '../resources/colors_resource.dart'; // ✅ Fixed import path
import '../resources/textplaceholder.dart'; // ✅ Fixed import path
import 'plant_details_screen.dart';

class Plant {
  final String name;
  final String category;
  final String location;
  final String imagePath;
  Plant({required this.name, required this.category, required this.location, required this.imagePath});
}

class BrowsePlantScreen extends StatefulWidget {
  const BrowsePlantScreen({super.key});

  @override
  State<BrowsePlantScreen> createState() => _BrowsePlantScreenState();
}

class _BrowsePlantScreenState extends State<BrowsePlantScreen> {
  String _selectedFilter = "All";

  final List<Plant> _allPlants = [
    Plant(name: "Aloe Vera", category: "Medicinal", location: "Indoor", imagePath: 'assets/images/aloe_vera.jpg'),
    Plant(name: "Snake Plant", category: "Air Purifying", location: "Indoor", imagePath: 'assets/images/snake_plant.jpg'),
    Plant(name: "Money Plant", category: "Low Maintenance", location: "Indoor", imagePath: 'assets/images/money_plant.jpg'),
    Plant(name: "Cactus Trio", category: "Drought Tolerant", location: "Terrace", imagePath: 'assets/images/cactus_trio.jpg'),
    Plant(name: "Peace Lily", category: "Flowering", location: "Indoor", imagePath: 'assets/images/peace_lily.jpg'),
    Plant(name: "Calathea", category: "Decorative", location: "Balcony", imagePath: 'assets/images/calathea_plant.jpg'),
    Plant(name: "Bougainvillea", category: "Flowering Vine", location: "Outdoor", imagePath: 'assets/images/bougainvillea.jpg'),
    Plant(name: "Rose Plant", category: "Flowering", location: "Terrace", imagePath: 'assets/images/rose_plant.jpg'),
  ];

  final List<String> _filters = ["All", "Indoor", "Outdoor", "Balcony", "Terrace"];

  List<Plant> get _filteredPlants {
    if (_selectedFilter == "All") return _allPlants;
    return _allPlants.where((plant) => plant.location == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      // ✅ ADDED APPBAR FOR EASY BACK NAVIGATION
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        title: const Text("Explore Plants", style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Reduced top padding since AppBar is there
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Find the perfect addition to your living room, balcony, or terrace.", style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.4)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
              child: const Row(children: [Icon(Icons.search, color: Colors.grey), SizedBox(width: 10), Expanded(child: TextField(decoration: InputDecoration(hintText: "Search plants by name...", border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey))))]),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = filter == _selectedFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: isSelected ? AppColors.buttonColor : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? AppColors.buttonColor : Colors.grey.shade300)),
                      alignment: Alignment.center,
                      child: Text(filter, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            if (_filteredPlants.isEmpty)
              const Center(child: Padding(padding: EdgeInsets.all(32.0), child: Text("No plants found for this location yet.", style: TextStyle(color: Colors.grey, fontSize: 16), textAlign: TextAlign.center)))
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.75),
                itemCount: _filteredPlants.length,
                itemBuilder: (context, index) => _buildPlantCard(_filteredPlants[index]),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantCard(Plant plant) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 110, width: double.infinity, color: const Color(0xFFE0E0E0),
              child: Image.asset(plant.imagePath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.eco, size: 50, color: Colors.grey)),
            ),
          ),
          const SizedBox(height: 10),
          Text(plant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppColors.lightGreenCard, borderRadius: BorderRadius.circular(8)),
            child: Text("${plant.location} • ${plant.category}", style: const TextStyle(fontSize: 11, color: AppColors.primaryText, fontWeight: FontWeight.w600)),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity, height: 32,
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PlantDetailsScreen(plant: plant))),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 8)),
              child: const Text("View Details →", style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}