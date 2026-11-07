import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';
import 'my_garden_screen.dart';
import 'add_plant_screen.dart';
import 'reminders_screen.dart';
import 'user_browse_tips_screen.dart';
import 'user_profile_screen.dart';
import 'user_plant_details_screen.dart';
import 'general_notifications_screen.dart';

class UserHomeScreen extends StatelessWidget {
  final List<UserPlant> allPlants;
  final Function(String, String, String) onUpdatePlant;
  final Function(UserPlant) onAddToGarden;
  final VoidCallback onLogout;

  const UserHomeScreen({
    super.key,
    required this.allPlants,
    required this.onUpdatePlant,
    required this.onAddToGarden,
    required this.onLogout,
  });

  List<UserPlant> get _todayReminders {
    final today = DateTime.now();
    return allPlants.where((plant) {
      return plant.nextCareDate.year == today.year &&
             plant.nextCareDate.month == today.month &&
             plant.nextCareDate.day == today.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("EcoLeaf", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.buttonColor, fontFamily: 'serif')),
                      Text("Your Home Garden Companion", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: AppColors.buttonColor, size: 24),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RemindersScreen(allPlants: allPlants))),
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_outline, color: AppColors.buttonColor, size: 24),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(onLogout: onLogout))),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text("Good Morning, Nandita! 👋", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
              const SizedBox(height: 20),
              
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MyGardenScreen(allPlants: allPlants, onUpdatePlant: onUpdatePlant))),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.buttonColor, Color(0xFF4CAF50)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: AppColors.buttonColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("My Garden", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("Keep your plants happy", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ]),
                          Row(children: [
                            Text("View All", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatBox(allPlants.length.toString(), "Total Plants", Icons.eco),
                          Container(width: 1, height: 50, color: Colors.white.withOpacity(0.3)),
                          _buildStatBox(_todayReminders.length.toString(), "Today's Tasks", Icons.notifications_active),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildQuickActionGridItem(icon: Icons.add_circle_outline, label: "Add Plant", color: AppColors.buttonColor, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddPlantScreen(onAddPlant: onAddToGarden)))),
                  _buildQuickActionGridItem(icon: Icons.eco_outlined, label: "My Garden", color: Colors.green, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MyGardenScreen(allPlants: allPlants, onUpdatePlant: onUpdatePlant)))),
                  _buildQuickActionGridItem(icon: Icons.notifications_outlined, label: "Reminders", color: Colors.orange, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RemindersScreen(allPlants: allPlants)))),
                  _buildQuickActionGridItem(icon: Icons.menu_book_outlined, label: "Browse Tips", color: Colors.blue, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserBrowseTipsScreen()))),
                ],
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Today's Reminder", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RemindersScreen(allPlants: allPlants))),
                    child: const Text("See All", style: TextStyle(color: AppColors.buttonColor, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (_todayReminders.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)),
                  child: const Row(children: [Icon(Icons.check_circle_outline, color: Colors.green, size: 24), SizedBox(width: 12), Expanded(child: Text("No reminders for today! Enjoy your day.", style: TextStyle(color: Colors.black54, fontSize: 14)))]),
                )
              else
                Column(children: _todayReminders.take(2).map((plant) => _buildTodayReminderCard(plant)).toList()),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String number, String label, IconData icon) {
    return Column(children: [
      Icon(icon, color: Colors.white, size: 24),
      const SizedBox(height: 8),
      Text(number, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500)),
    ]);
  }

  Widget _buildQuickActionGridItem({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 28)),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayReminderCard(UserPlant plant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.buttonColor.withOpacity(0.2), width: 1), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.buttonColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.water_drop, color: AppColors.buttonColor, size: 22)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.reminderText.split('•').first.trim(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                const SizedBox(height: 4),
                Text(plant.location, style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Text("Today", style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}