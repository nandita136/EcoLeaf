import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import 'user_plant_details_screen.dart';

class AddPlantScreen extends StatefulWidget {
  final Function(UserPlant) onAddPlant;
  const AddPlantScreen({super.key, required this.onAddPlant});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText, size: 20), onPressed: () => Navigator.pop(context)),
        title: const Text('Add Plant', style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 150, height: 150,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.buttonColor.withOpacity(0.3), width: 2)),
                    child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, size: 40, color: Colors.grey), SizedBox(height: 8), Text('Upload Plant Photo', style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center)]),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(controller: _nameController, label: 'Plant Name', validator: (value) => value == null || value.isEmpty ? 'Please enter plant name' : null),
                const SizedBox(height: 16),
                _buildTextField(controller: _typeController, label: 'Plant Type (e.g., Indoor, Succulent)'),
                const SizedBox(height: 16),
                _buildTextField(controller: _locationController, label: 'Location (e.g., Living Room, Balcony)'),
                const SizedBox(height: 16),
                _buildTextField(controller: _notesController, label: 'Notes...', maxLines: 4),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity, height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newPlant = UserPlant(
                          name: _nameController.text,
                          notes: _notesController.text,
                          location: _locationController.text,
                          sunlight: _typeController.text,
                          lastWatered: "Just now",
                          reminderText: "Water in 7 days",
                          nextCareDate: DateTime.now().add(const Duration(days: 7)),
                          imagePath: 'assets/images/aloe_vera.jpg', // Default mock image
                        );
                        widget.onAddPlant(newPlant);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plant added successfully!'), backgroundColor: AppColors.buttonColor));
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                    child: const Text('Save Plant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, int maxLines = 1, String? Function(String?)? validator}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]),
      child: TextFormField(
        controller: controller, maxLines: maxLines, validator: validator,
        decoration: InputDecoration(hintText: label, hintStyle: const TextStyle(color: Colors.grey), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose(); _typeController.dispose(); _locationController.dispose(); _notesController.dispose();
    super.dispose();
  }
}