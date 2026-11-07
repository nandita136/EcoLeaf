  import 'package:flutter/material.dart';
  import '../../resources/colors_resource.dart';

  class UserBrowseTipsScreen extends StatefulWidget {
    const UserBrowseTipsScreen({super.key});

    @override
    State<UserBrowseTipsScreen> createState() => _UserBrowseTipsScreenState();
  }

  class _UserBrowseTipsScreenState extends State<UserBrowseTipsScreen> {
    final TextEditingController _plantNameController = TextEditingController();
    final TextEditingController _plantTypeController = TextEditingController();
    bool _hasSearched = false;

    // Mock data for demonstration
    Map<String, Map<String, String>> _plantTips = {
      'aloe vera': {
        'watering': 'Water deeply but infrequently. Allow soil to dry out completely between waterings.',
        'light': 'Bright, indirect sunlight. Can tolerate some direct morning sun.',
        'soil': 'Well-draining cactus or succulent mix.',
      },
      'snake plant': {
        'watering': 'Water every 2-3 weeks. Very drought tolerant.',
        'light': 'Adaptable to low light, but thrives in bright, indirect light.',
        'soil': 'Standard potting mix with added perlite for drainage.',
      },
      'peace lily': {
        'watering': 'Keep soil consistently moist but not soggy. Droops when it needs water.',
        'light': 'Low to medium indirect light. Avoid direct sun.',
        'soil': 'Rich, well-draining potting soil.',
      }
    };

    void _searchTips() {
      if (_plantNameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a plant name'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      setState(() {
        _hasSearched = true;
      });
    }

    Map<String, String>? _getTipsForPlant() {
      String name = _plantNameController.text.trim().toLowerCase();
      for (var key in _plantTips.keys) {
        if (name.contains(key)) return _plantTips[key];
      }
      return null; 
    }

    @override
    Widget build(BuildContext context) {
      final tips = _hasSearched ? _getTipsForPlant() : null;
      final plantName = _plantNameController.text.trim();
      final plantType = _plantTypeController.text.trim();

      return Scaffold(
        backgroundColor: AppColors.screenBackground,
        appBar: AppBar(
          backgroundColor: AppColors.screenBackground,
          elevation: 0,
          // ✅ Added Back Button in top left
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Browse Tips',
            style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find Care Tips',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your plant details to get personalized care advice.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),

              // Plant Name Input (No Icon)
              _buildInputField(
                controller: _plantNameController,
                label: 'Plant Name',
                hint: 'e.g., Aloe Vera, Snake Plant',
              ),
              const SizedBox(height: 16),

              // Plant Type Input (No Icon)
              _buildInputField(
                controller: _plantTypeController,
                label: 'Plant Type',
                hint: 'e.g., Indoor, Succulent, Flowering',
              ),
              const SizedBox(height: 24),

              // Search Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _searchTips,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Get Care Tips',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Results Section
              if (_hasSearched) ...[
                const Divider(height: 1),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.buttonColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Tips for ${plantName.isNotEmpty ? plantName : "Your Plant"}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                    ),
                  ],
                ),
                if (plantType.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 4),
                    child: Text(
                      'Type: $plantType',
                      style: const TextStyle(fontSize: 13, color: Colors.black54, fontStyle: FontStyle.italic),
                    ),
                  ),
                const SizedBox(height: 20),

                if (tips != null) ...[
                  _buildTipCard('Watering', tips['watering']!, Colors.blue),
                  const SizedBox(height: 12),
                  _buildTipCard('Sunlight', tips['light']!, Colors.orange),
                  const SizedBox(height: 12),
                  _buildTipCard('Soil', tips['soil']!, Colors.brown),
                ] else ...[
                  _buildTipCard('General Watering', 'Water when the top inch of soil feels dry. Avoid overwatering.', Colors.blue),
                  const SizedBox(height: 12),
                  _buildTipCard('General Light', 'Most plants thrive in bright, indirect sunlight.', Colors.orange),
                  const SizedBox(height: 12),
                  _buildTipCard('Pro Tip', 'Research specific needs for "$plantName" to ensure optimal growth!', Colors.green),
                ],
              ],
            ],
          ),
        ),
      );
    }

    Widget _buildInputField({
      required TextEditingController controller,
      required String label,
      required String hint,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryText),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildTipCard(String title, String description, Color color) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
            ),
          ],
        ),
      );
    }

    @override
    void dispose() {
      _plantNameController.dispose();
      _plantTypeController.dispose();
      super.dispose();
    }
  }