import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../resources/colors_resource.dart';

// Model for User's Plant (Keep this here or in a shared models file)
class UserPlant {
  String name;
  String notes;
  final String location;
  final String sunlight;
  final String lastWatered;
  final String reminderText;
  final DateTime nextCareDate;
  final String imagePath;
  final String status;

  UserPlant({
    required this.name,
    required this.notes,
    required this.location,
    required this.sunlight,
    required this.lastWatered,
    required this.reminderText,
    required this.nextCareDate,
    required this.imagePath,
    this.status = "Healthy",
  });
}

// ✅ RENAMED TO UserPlantDetailsScreen
class UserPlantDetailsScreen extends StatefulWidget {
  final UserPlant plant;
  final Function(String newName, String newNotes) onUpdatePlant;

  const UserPlantDetailsScreen({
    super.key,
    required this.plant,
    required this.onUpdatePlant,
  });

  @override
  State<UserPlantDetailsScreen> createState() => _UserPlantDetailsScreenState();
}

// ✅ RENAMED STATE CLASS
class _UserPlantDetailsScreenState extends State<UserPlantDetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  bool _isEditing = false;
  String _lastUpdated = "Aug 15";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plant.name);
    _notesController = TextEditingController(text: widget.plant.notes);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    widget.onUpdatePlant(_nameController.text, _notesController.text);
    setState(() {
      _isEditing = false;
      _lastUpdated = DateFormat('MMM d').format(DateTime.now());
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Changes saved successfully!"),
        backgroundColor: AppColors.buttonColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.screenBackground,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText),
            ),
            actions: [
              if (_isEditing) ...[
                TextButton(
                  onPressed: () {
                    _nameController.text = widget.plant.name;
                    _notesController.text = widget.plant.notes;
                    setState(() => _isEditing = false);
                  },
                  child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
                ),
                ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ] else
                IconButton(
                  onPressed: () => setState(() => _isEditing = true),
                  icon: const Icon(Icons.edit_outlined, color: AppColors.buttonColor),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Plant Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Container(
                      color: const Color(0xFFE8F5E9),
                      child: Image.asset(
                        widget.plant.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.eco, size: 80, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plant Name & Status
                  Row(
                    children: [
                      Expanded(
                        child: _isEditing
                            ? TextField(
                                controller: _nameController,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              )
                            : Text(
                                widget.plant.name,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            const Text("Healthy", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location & Sunlight
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(widget.plant.location, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                      const SizedBox(width: 16),
                      const Icon(Icons.wb_sunny_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(widget.plant.sunlight, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Care Tips Section
                  const Text("Care Tips", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  const SizedBox(height: 16),

                  _buildCareTipCard(
                    Icons.water_drop_outlined,
                    "Watering Schedule",
                    "Every 10 days. Water the soil completely. Dry before rewatering.",
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildCareTipCard(
                    Icons.wb_sunny_outlined,
                    "Sunlight Needs",
                    "Needs 6-8 hours of bright, direct sunlight daily for optimal growth.",
                    Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildCareTipCard(
                    Icons.landscape_outlined,
                    "Soil & Potting",
                    "Use well-draining cactus mix to prevent root rot.",
                    Colors.brown,
                  ),
                  const SizedBox(height: 24),

                  // My Notes Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("My Notes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                      if (_isEditing)
                        TextButton(
                          onPressed: _saveChanges,
                          child: const Text("Save", style: TextStyle(color: AppColors.buttonColor, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "UPDATED ${_lastUpdated.toUpperCase()}",
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            const Text(
                              "Active Log",
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.buttonColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _isEditing
                            ? TextField(
                                controller: _notesController,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Write your notes here...",
                                ),
                              )
                            : Text(
                                widget.plant.notes,
                                style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareTipCard(IconData icon, String title, String description, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}