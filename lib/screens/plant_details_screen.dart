import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import '../resources/textplaceholder.dart';
import 'signup_screen.dart'; 

// Note: Assuming 'Plant' is your model for the guest/explore screens. 
// If it's named differently, adjust sthe import/type accordingly.
class PlantDetailsScreen extends StatelessWidget {
  final dynamic plant; // Using dynamic or your specific Plant model
  final VoidCallback? onSignupSuccess; // ✅ Optional callback for signup

  const PlantDetailsScreen({
    super.key,
    required this.plant,
    this.onSignupSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TOP IMAGE SECTION ---
            Stack(
              children: [
                // Plant Image
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0E0E0),
                  ),
                  child: Image.asset(
                    plant.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.eco, size: 80, color: Colors.grey),
                      );
                    },
                  ),
                ),
                
                // Back Button & Header
                Positioned(
                  top: 40,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                      const Text(
                        "Plant Info", // Replaced placeholder for clarity, or use TextPlaceholders.plantInfoHeader
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(width: 40), // Balance the row
                    ],
                  ),
                ),
                
                // Plant Name & Category (Overlaid on image bottom)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          plant.category, 
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // --- MAIN CONTENT ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- ABOUT THE PLANT ---
                  const Text(
                    "About the Plant",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getAboutPlant(plant.name),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- ADVANTAGES ---
                  const Text(
                    "Advantages",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.buttonColor, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getAdvantages(plant.name),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // --- SUITABLE LOCATIONS ---
                  const Text(
                    "Suitable Locations",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _getSuitableLocations(plant.name).map((location) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreenCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.buttonColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          location,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),

                  // --- CREATE ACCOUNT BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // ✅ Navigate to Sign Up Screen and pass the callback
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(
                              onSignupSuccess: onSignupSuccess ?? () {},
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      label: const Text(
                        "Create Account to Save",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 2,
                      ),
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

  // --- CLEANED UP DATA HELPER METHODS ---

  String _getAboutPlant(String plantName) {
    final aboutMap = {
      'Aloe Vera': 'A succulent plant species known for its thick, fleshy leaves that contain a soothing, medicinal gel.',
      'Snake Plant': 'Features upright, sword-like leaves and is widely considered one of the most tolerant and resilient houseplants.',
      'Money Plant': 'A highly popular trailing plant loved for its beautiful, heart-shaped green and yellow variegated leaves.',
      'Cactus Trio': 'Drought-tolerant succulents that store water in their thick stems, featuring unique shapes and protective spines.',
      'Peace Lily': 'An elegant indoor flowering plant famous for its striking white blooms and deep, glossy green leaves.',
      'Calathea': 'Known for its stunning decorative leaves with intricate, unique patterns that actually move in response to light.',
      'Bougainvillea': 'A vibrant, thorny flowering vine famous for its colorful, paper-like bracts that bloom profusely in the sun.',
      'Rose Plant': 'Classic flowering shrubs beloved worldwide for their fragrant, multi-petaled blooms and timeless beauty.',
    };
    return aboutMap[plantName] ?? 'A beautiful plant that adds life, freshness, and natural charm to your space.';
  }

  String _getAdvantages(String plantName) {
    final advantagesMap = {
      'Aloe Vera': 'Heals minor burns, purifies indoor air, and requires very minimal maintenance.',
      'Snake Plant': 'Excellent air purifier that releases oxygen at night and thrives on neglect.',
      'Money Plant': 'Believed to bring good luck, removes indoor toxins, and grows rapidly.',
      'Cactus Trio': 'Needs very little water, adds a stylish desert aesthetic, and blooms beautifully.',
      'Peace Lily': 'Thrives in low light, boosts room humidity, and filters common airborne toxins.',
      'Calathea': 'Completely non-toxic to pets, acts as a natural humidifier, and reduces stress.',
      'Bougainvillea': 'Provides excellent shade, attracts pollinators, and blooms year-round in warm climates.',
      'Rose Plant': 'Offers beautiful cut flowers, has various medicinal uses, and attracts beneficial insects.',
    };
    return advantagesMap[plantName] ?? 'Enhances your space with natural beauty and improves overall well-being.';
  }

  List<String> _getSuitableLocations(String plantName) {
    final locationsMap = {
      'Aloe Vera': ['Indoor', 'Balcony'],
      'Snake Plant': ['Indoor', 'Outdoor', 'Balcony'],
      'Money Plant': ['Indoor', 'Balcony', 'Terrace'],
      'Cactus Trio': ['Terrace', 'Outdoor', 'Balcony'],
      'Peace Lily': ['Indoor', 'Balcony'],
      'Calathea': ['Indoor'],
      'Bougainvillea': ['Outdoor', 'Terrace', 'Balcony'],
      'Rose Plant': ['Outdoor', 'Terrace', 'Balcony'],
    };
    return locationsMap[plantName] ?? ['Indoor', 'Outdoor'];
  }
}