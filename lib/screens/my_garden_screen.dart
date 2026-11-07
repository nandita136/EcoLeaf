import 'package:flutter/material.dart';
import '../../resources/colors_resource.dart';
import 'user_plant_details_screen.dart';

class MyGardenScreen extends StatefulWidget {
  final List<UserPlant> allPlants;
  final Function(String oldName, String newName, String newNotes) onUpdatePlant;

  const MyGardenScreen({
    super.key,
    required this.allPlants,
    required this.onUpdatePlant,
  });

  @override
  State<MyGardenScreen> createState() => _MyGardenScreenState();
}

class _MyGardenScreenState extends State<MyGardenScreen> {
  bool _isEditing = false;
  String _searchQuery = '';
  Set<String> _selectedPlantNames = {};

  List<UserPlant> get _filteredPlants {
    var plants = List<UserPlant>.from(widget.allPlants);
    if (_searchQuery.isNotEmpty) {
      plants = plants.where((plant) =>
        plant.name.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    plants.sort((a, b) => a.nextCareDate.compareTo(b.nextCareDate));
    return plants;
  }

  void _toggleSelection(String name) {
    if (!mounted) return;
    setState(() {
      if (_selectedPlantNames.contains(name)) {
        _selectedPlantNames.remove(name);
      } else {
        _selectedPlantNames.add(name);
      }
    });
  }

  void _deleteSelected() {
    if (!mounted) return;
    setState(() {
      widget.allPlants.removeWhere((plant) => _selectedPlantNames.contains(plant.name));
      _selectedPlantNames.clear();
      _isEditing = false; // Exit edit mode after bulk deletion
    });
  }

  void _showEditDialog(UserPlant plant) {
    TextEditingController controller = TextEditingController(text: plant.name);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Edit Plant Name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter new name"),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (mounted) {
                widget.onUpdatePlant(plant.name, controller.text, plant.notes);
                Navigator.pop(dialogContext);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor),
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _openPlantDetails(UserPlant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserPlantDetailsScreen(
          plant: plant,
          onUpdatePlant: (newName, newNotes) {
            widget.onUpdatePlant(plant.name, newName, newNotes);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
              right: 20,
              bottom: 12,
            ),
            color: AppColors.screenBackground,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText, size: 20),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("My Garden", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                      if (!_isEditing)
                        const Text("Keep tabs on watering, light, and care", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
                if (_isEditing) ...[
                  TextButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          _isEditing = false;
                          _selectedPlantNames.clear();
                        });
                      }
                    },
                    child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (mounted) setState(() => _isEditing = false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ] else
                  TextButton(
                    onPressed: () {
                      if (mounted) setState(() => _isEditing = true);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 16, color: AppColors.buttonColor),
                        SizedBox(width: 4),
                        Text("Edit", style: TextStyle(color: AppColors.buttonColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!_isEditing) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.grey, size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      if (mounted) setState(() => _searchQuery = value);
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Search your plants...",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        if (_isEditing) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Selected (${_selectedPlantNames.length}/${widget.allPlants.length})",
                                style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
                              ),
                              if (_selectedPlantNames.isNotEmpty)
                                GestureDetector(
                                  onTap: _deleteSelected,
                                  child: const Row(
                                    children: [
                                      Icon(Icons.delete_outline, color: Colors.red, size: 18),
                                      SizedBox(width: 4),
                                      Text("Delete", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final plant = _filteredPlants[index];
                        final isSelected = _selectedPlantNames.contains(plant.name);
                        return _buildPlantCard(plant, isSelected);
                      },
                      childCount: _filteredPlants.length,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantCard(UserPlant plant, bool isSelected) {
    return GestureDetector(
      onTap: _isEditing ? () => _toggleSelection(plant.name) : () => _openPlantDetails(plant),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: AppColors.buttonColor, width: 2) : null,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            if (_isEditing) ...[
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? AppColors.buttonColor : Colors.grey.shade400,
                  size: 24,
                ),
              ),
            ],
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 70,
                width: 70,
                color: const Color(0xFFE0E0E0),
                child: Image.asset(
                  plant.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.eco, size: 30, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plant.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  const SizedBox(height: 6),
                  Text("Location: ${plant.location}", style: const TextStyle(fontSize: 13, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(
                    "Reminder: ${plant.reminderText}",
                    style: TextStyle(fontSize: 12, color: AppColors.buttonColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            if (_isEditing) ...[
              IconButton(
                onPressed: () => _showEditDialog(plant),
                icon: const Icon(Icons.edit_outlined, color: Colors.grey, size: 20),
              ),
              IconButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      widget.allPlants.remove(plant);
                      _selectedPlantNames.remove(plant.name); // ✅ Clean up selection if deleted
                    });
                  }
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), // ✅ Changed to red for clarity
              ),
            ] else
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}