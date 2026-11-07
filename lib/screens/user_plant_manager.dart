  import 'package:flutter/material.dart';
  import 'user_home_screen.dart';
  import 'user_plant_details_screen.dart';

  class UserPlantManager extends StatefulWidget {
    final VoidCallback onLogout;
    const UserPlantManager({super.key, required this.onLogout});

    @override
    State<UserPlantManager> createState() => _UserPlantManagerState();
  }

  class _UserPlantManagerState extends State<UserPlantManager> {
    // ✅ EXPANDED TO 20 DIVERSE PLANTS
    final List<UserPlant> _allPlants = [
      // --- TODAY'S CARE (Urgent) ---
      UserPlant(
        name: "Aloe Vera", location: "Balcony", sunlight: "Bright shade",
        lastWatered: "2 days ago", reminderText: "Water • Today 8:00 AM",
        nextCareDate: DateTime.now().add(const Duration(hours: 2)),
        imagePath: 'assets/images/aloe_vera.jpg', notes: "Growing well, new pups appearing.",
      ),
      UserPlant(
        name: "Money Plant", location: "Study Room", sunlight: "Indirect light",
        lastWatered: "3 days ago", reminderText: "Fertilize • Today 2:00 PM",
        nextCareDate: DateTime.now().add(const Duration(hours: 5)),
        imagePath: 'assets/images/money_plant.jpg', notes: "Trailing nicely from the shelf.",
      ),
      UserPlant(
        name: "Rose Plant", location: "Terrace", sunlight: "Full sun",
        lastWatered: "1 day ago", reminderText: "Prune dead blooms • Today 6:00 PM",
        nextCareDate: DateTime.now().add(const Duration(hours: 8)),
        imagePath: 'assets/images/rose_plant.jpg', notes: "Blooming season in full swing!",
      ),

      // --- TOMORROW'S CARE ---
      UserPlant(
        name: "Peace Lily", location: "Living Room", sunlight: "Medium light",
        lastWatered: "4 days ago", reminderText: "Check soil • Tomorrow 9:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 1)),
        imagePath: 'assets/images/peace_lily.jpg', notes: "Blooming beautifully.",
      ),
      UserPlant(
        name: "Calathea", location: "Bathroom", sunlight: "Shade",
        lastWatered: "2 days ago", reminderText: "Wipe leaves • Tomorrow 8:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 1)),
        imagePath: 'assets/images/calathea_plant.jpg', notes: "Loves high humidity.",
      ),
      UserPlant(
        name: "Fern", location: "Bedroom", sunlight: "Indirect light",
        lastWatered: "3 days ago", reminderText: "Mist leaves • Tomorrow 7:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 1)),
        imagePath: 'assets/images/fern.jpg', notes: "Needs regular misting.",
      ),

      // --- THIS WEEK'S CARE ---
      UserPlant(
        name: "Snake Plant", location: "Bedroom", sunlight: "Low light",
        lastWatered: "1 week ago", reminderText: "Mist leaves • Oct 15 • 10:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 3)),
        imagePath: 'assets/images/snake_plant.jpg', notes: "Needs less water in winter.",
      ),
      UserPlant(
        name: "Bougainvillea", location: "Garden", sunlight: "Full sun",
        lastWatered: "5 days ago", reminderText: "Prune branches • Oct 16 • 11:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 4)),
        imagePath: 'assets/images/bougainvillea.jpg', notes: "Flowering season starting!",
      ),
      UserPlant(
        name: "Cactus Trio", location: "Terrace", sunlight: "Direct sun",
        lastWatered: "2 weeks ago", reminderText: "Rotate pot • Oct 17 • 9:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 5)),
        imagePath: 'assets/images/cactus_trio.jpg', notes: "Thriving in the sun.",
      ),
      UserPlant(
        name: "Monstera Deliciosa", location: "Living Room", sunlight: "Bright indirect",
        lastWatered: "4 days ago", reminderText: "Water & Dust leaves • Oct 18 • 9:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 6)),
        imagePath: 'assets/images/monstera.jpg', notes: "New leaf unfurling!",
      ),
      UserPlant(
        name: "Spider Plant", location: "Bedroom", sunlight: "Bright indirect",
        lastWatered: "3 days ago", reminderText: "Water • Oct 19 • 10:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 7)),
        imagePath: 'assets/images/spider_plant.jpg', notes: "Producing lots of spiderettes.",
      ),

      // --- NEXT WEEK'S CARE ---
      UserPlant(
        name: "ZZ Plant", location: "Office Desk", sunlight: "Low to bright",
        lastWatered: "2 weeks ago", reminderText: "Water lightly • Oct 20 • 9:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 8)),
        imagePath: 'assets/images/zz_plant.jpg', notes: "Very low maintenance, doing great.",
      ),
      UserPlant(
        name: "Pothos", location: "Kitchen", sunlight: "Low to bright",
        lastWatered: "5 days ago", reminderText: "Water • Oct 21 • 8:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 9)),
        imagePath: 'assets/images/pothos.jpg', notes: "Growing rapidly, needs trimming.",
      ),
      UserPlant(
        name: "Rubber Plant", location: "Hallway", sunlight: "Bright indirect",
        lastWatered: "6 days ago", reminderText: "Water • Oct 22 • 10:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 10)),
        imagePath: 'assets/images/rubber_plant.jpg', notes: "Shiny leaves, loves humidity.",
      ),
      UserPlant(
        name: "Jade Plant", location: "Window Sill", sunlight: "Bright direct",
        lastWatered: "1 week ago", reminderText: "Water • Oct 23 • 9:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 11)),
        imagePath: 'assets/images/jade_plant.jpg', notes: "Succulent, needs minimal water.",
      ),

      // --- LONGER TERM CARE ---
      UserPlant(
        name: "Fiddle Leaf Fig", location: "Living Room", sunlight: "Bright indirect",
        lastWatered: "1 week ago", reminderText: "Deep water • Oct 25 • 8:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 13)),
        imagePath: 'assets/images/fiddle_leaf.jpg', notes: "Statement plant, needs consistent care.",
      ),
      UserPlant(
        name: "Orchid", location: "Bedroom", sunlight: "Bright indirect",
        lastWatered: "10 days ago", reminderText: "Mist & fertilize • Oct 28 • 10:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 16)),
        imagePath: 'assets/images/orchid.jpg', notes: "Delicate but beautiful when blooming.",
      ),
      UserPlant(
        name: "Lavender", location: "Balcony", sunlight: "Full sun",
        lastWatered: "1 week ago", reminderText: "Prune after flowering • Nov 1 • 9:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 20)),
        imagePath: 'assets/images/lavender.jpg', notes: "Fragrant and attracts pollinators.",
      ),
      UserPlant(
        name: "Bamboo Palm", location: "Office", sunlight: "Indirect light",
        lastWatered: "5 days ago", reminderText: "Water • Nov 5 • 8:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 24)),
        imagePath: 'assets/images/bamboo_palm.jpg', notes: "Great air purifier.",
      ),
      UserPlant(
        name: "Succulent Collection", location: "Window Sill", sunlight: "Bright direct",
        lastWatered: "2 weeks ago", reminderText: "Water lightly • Nov 10 • 9:00 AM",
        nextCareDate: DateTime.now().add(const Duration(days: 29)),
        imagePath: 'assets/images/succulents.jpg', notes: "Multiple varieties, all thriving.",
      ),
    ];

    void _updatePlant(String oldName, String newName, String newNotes) {
      setState(() {
        final plant = _allPlants.firstWhere((p) => p.name == oldName);
        plant.name = newName;
        plant.notes = newNotes;
      });
    }

    void _addToGarden(UserPlant newPlant) {
      setState(() {
        if (!_allPlants.any((p) => p.name == newPlant.name)) {
          _allPlants.add(newPlant);
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return UserHomeScreen(
        allPlants: _allPlants,
        onUpdatePlant: _updatePlant,
        onAddToGarden: _addToGarden,
        onLogout: widget.onLogout,
      );
    }
  }