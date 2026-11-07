import 'package:flutter/material.dart';
import '../resources/colors_resource.dart';

class NotificationItem {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final String time;
  final String category; // "Reminder", "New Plant", "General"

  NotificationItem({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.time,
    required this.category,
  });
}

class GeneralNotificationsScreen extends StatelessWidget {
  const GeneralNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ ALL NOTIFICATIONS IN ONE UNIFIED FEED
    final List<NotificationItem> notifications = [
      // --- PLANT CARE REMINDERS ---
      NotificationItem(
        category: "Reminder",
        title: "Water Aloe Vera",
        message: "Your Aloe Vera needs watering today at 8:00 AM. Soil is dry.",
        icon: Icons.water_drop,
        iconColor: Colors.blue,
        time: "2 hours ago",
      ),
      NotificationItem(
        category: "Reminder",
        title: "Fertilize Money Plant",
        message: "Time to fertilize your Money Plant today at 2:00 PM.",
        icon: Icons.eco,
        iconColor: Colors.green,
        time: "5 hours ago",
      ),
      NotificationItem(
        category: "Reminder",
        title: "Mist Snake Plant",
        message: "Light misting scheduled for tomorrow at 10:00 AM.",
        icon: Icons.air,
        iconColor: Colors.cyan,
        time: "1 day ago",
      ),

      // --- NEW PLANTS ADDED FROM EXPLORE ---
      NotificationItem(
        category: "New Plant",
        title: "Snake Plant Added to Garden",
        message: "You added Snake Plant from Explore. Welcome it to your collection!",
        icon: Icons.add_circle,
        iconColor: Colors.teal,
        time: "1 day ago",
      ),
      NotificationItem(
        category: "New Plant",
        title: "Peace Lily Added to Garden",
        message: "Peace Lily is now part of your garden. It loves medium light.",
        icon: Icons.add_circle,
        iconColor: Colors.purple,
        time: "2 days ago",
      ),
      NotificationItem(
        category: "New Plant",
        title: "Calathea Added to Garden",
        message: "New addition! Calathea loves humidity and indirect light.",
        icon: Icons.add_circle,
        iconColor: Colors.indigo,
        time: "3 days ago",
      ),

      // --- GENERAL APP NOTIFICATIONS ---
      NotificationItem(
        category: "General",
        title: "Welcome to EcoLeaf!",
        message: "Thanks for joining our plant-loving community. Let's grow together!",
        icon: Icons.celebration,
        iconColor: Colors.pink,
        time: "4 days ago",
      ),
      NotificationItem(
        category: "General",
        title: "New Care Tip Available",
        message: "Learn the secret to making your Peace Lily bloom all year round.",
        icon: Icons.auto_stories,
        iconColor: Colors.orange,
        time: "5 days ago",
      ),
      NotificationItem(
        category: "General",
        title: "Weather Alert",
        message: "Temperature dropping tonight. Bring your outdoor plants inside!",
        icon: Icons.cloud,
        iconColor: Colors.blueGrey,
        time: "6 days ago",
      ),
      NotificationItem(
        category: "General",
        title: "Weekly Garden Report",
        message: "Your garden health score is 92%. Keep up the great work!",
        icon: Icons.insights,
        iconColor: Colors.green,
        time: "1 week ago",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SUMMARY CARDS ---
            Row(
              children: [
                _buildSummaryCard("Reminders", notifications.where((n) => n.category == "Reminder").length.toString(), Icons.water_drop, Colors.blue),
                const SizedBox(width: 12),
                _buildSummaryCard("New Plants", notifications.where((n) => n.category == "New Plant").length.toString(), Icons.add_circle, Colors.teal),
                const SizedBox(width: 12),
                _buildSummaryCard("Updates", notifications.where((n) => n.category == "General").length.toString(), Icons.notifications, Colors.orange),
              ],
            ),
            const SizedBox(height: 24),

            // --- ALL NOTIFICATIONS ---
            const Text(
              "All Notifications",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
            ),
            const SizedBox(height: 16),
            ...notifications.map((notif) => _buildNotificationCard(notif)).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- SUMMARY CARD WIDGET ---
  Widget _buildSummaryCard(String label, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // --- NOTIFICATION CARD WIDGET ---
  Widget _buildNotificationCard(NotificationItem notif) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notif.category == "Reminder" 
              ? Colors.blue.withOpacity(0.2) 
              : notif.category == "New Plant" 
                  ? Colors.teal.withOpacity(0.2) 
                  : Colors.grey.withOpacity(0.1),
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notif.iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(notif.icon, color: notif.iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notif.title,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: notif.category == "Reminder" 
                            ? Colors.blue.withOpacity(0.1) 
                            : notif.category == "New Plant" 
                                ? Colors.teal.withOpacity(0.1) 
                                : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        notif.category,
                        style: TextStyle(
                          fontSize: 10, 
                          fontWeight: FontWeight.bold,
                          color: notif.category == "Reminder" 
                              ? Colors.blue 
                              : notif.category == "New Plant" 
                                  ? Colors.teal 
                                  : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notif.message,
                  style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
                ),
                const SizedBox(height: 8),
                Text(
                  notif.time,
                  style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}