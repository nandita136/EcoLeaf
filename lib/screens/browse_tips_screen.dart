import 'package:flutter/material.dart';
import '../resources/colors_resource.dart'; // ✅ Fixed import path
import '../resources/textplaceholder.dart'; // ✅ Fixed import path

class CareTip {
  final String title;
  final String description;
  final String category;
  CareTip({required this.title, required this.description, required this.category});
}

class TipCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final List<CareTip> tips;
  TipCategory({required this.title, required this.subtitle, required this.icon, required this.iconColor, required this.tips});
}

class BrowseTipsScreen extends StatefulWidget {
  const BrowseTipsScreen({super.key});

  @override
  State<BrowseTipsScreen> createState() => _BrowseTipsScreenState();
}

class _BrowseTipsScreenState extends State<BrowseTipsScreen> {
  String _searchQuery = '';

  final List<TipCategory> _allTipCategories = [
    TipCategory(title: "Drainage is Non-negotiable", subtitle: "Always use pots with bottom holes.", icon: Icons.water_drop, iconColor: Colors.blue, tips: [CareTip(title: "Use Drainage Layers", description: "Add a layer of small stones at the bottom of pots.", category: "Watering")]),
    TipCategory(title: "Light & Placement", subtitle: "Expert-approved guidelines for optimal garden success.", icon: Icons.lightbulb, iconColor: Colors.orange, tips: [CareTip(title: "The Window Rule", description: "South-facing windows offer bright, intense light.", category: "Light")]),
    TipCategory(title: "Seasonal Care", subtitle: "Adapt your care routine with the changing seasons.", icon: Icons.wb_sunny, iconColor: Colors.green, tips: [CareTip(title: "Winter Sleep Mode", description: "Most indoor plants go dormant in winter. Reduce watering.", category: "Seasonal")]),
  ];

  List<TipCategory> get _filteredCategories {
    if (_searchQuery.isEmpty) return _allTipCategories;
    final query = _searchQuery.toLowerCase();
    return _allTipCategories.map((category) {
      final filteredTips = category.tips.where((tip) => tip.title.toLowerCase().contains(query) || tip.description.toLowerCase().contains(query)).toList();
      return TipCategory(title: category.title, subtitle: category.subtitle, icon: category.icon, iconColor: category.iconColor, tips: filteredTips);
    }).where((category) => category.title.toLowerCase().contains(query) || category.tips.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      // ✅ ADDED APPBAR FOR EASY BACK NAVIGATION
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        title: const Text("Care Tips", style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Reduced top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Essential plant wisdom at your fingertips", style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.4)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey), const SizedBox(width: 10),
                  Expanded(child: TextField(onChanged: (value) => setState(() => _searchQuery = value), decoration: const InputDecoration(hintText: "Search tips...", border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey)))),
                  if (_searchQuery.isNotEmpty) GestureDetector(onTap: () => setState(() => _searchQuery = ''), child: const Icon(Icons.clear, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            ..._filteredCategories.map((category) => _buildCategorySection(category)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(TipCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: category.iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(category.icon, color: category.iconColor, size: 24)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(category.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)), const SizedBox(height: 4), Text(category.subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54))])),
          ],
        ),
        const SizedBox(height: 16),
        ...category.tips.map((tip) => _buildTipCard(tip)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTipCard(CareTip tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.lightGreenCard, borderRadius: BorderRadius.circular(12)), child: Text(tip.category, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryText))), const Spacer(), const Icon(Icons.info_outline, size: 18, color: Colors.grey)]),
          const SizedBox(height: 12),
          Text(tip.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
          const SizedBox(height: 8),
          Text(tip.description, style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.5)),
        ],
      ),
    );
  }
}