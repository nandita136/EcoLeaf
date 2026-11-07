import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../resources/colors_resource.dart';
import 'user_plant_details_screen.dart'; 
import 'add_reminder_screen.dart'; // ✅ Import the new screen

class RemindersScreen extends StatefulWidget {
  final List<UserPlant> allPlants;

  const RemindersScreen({
    super.key,
    required this.allPlants,
  });

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  Set<String> _completedTasks = {};
  Set<String> _completedUpcoming = {};

  String get _todayDate {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM d').format(now);
  }

  List<UserPlant> get _todayTasks {
    final today = DateTime.now();
    return widget.allPlants.where((plant) {
      final isToday = plant.nextCareDate.year == today.year &&
          plant.nextCareDate.month == today.month &&
          plant.nextCareDate.day == today.day;
      return isToday;
    }).toList();
  }

  List<UserPlant> get _upcomingCare {
    final today = DateTime.now();
    final nextWeek = today.add(const Duration(days: 7));
    return widget.allPlants.where((plant) {
      final isUpcoming = plant.nextCareDate.isAfter(today) &&
          plant.nextCareDate.isBefore(nextWeek);
      return isUpcoming;
    }).toList()..sort((a, b) => a.nextCareDate.compareTo(b.nextCareDate));
  }

  void _toggleTaskCompletion(String plantName) {
    setState(() {
      if (_completedTasks.contains(plantName)) {
        _completedTasks.remove(plantName);
      } else {
        _completedTasks.add(plantName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: CustomScrollView(
        slivers: [
          // ✅ Header with Back Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText, size: 20),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Reminders",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _todayDate,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),

          // Today's Tasks Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Tasks",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${_todayTasks.length} Tasks",
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox(height: 16)),

          // Today's Tasks List
          if (_todayTasks.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("No tasks for today! ", style: TextStyle(color: Colors.black54, fontSize: 14)),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final plant = _todayTasks[index];
                  final isCompleted = _completedTasks.contains(plant.name);
                  return _buildTodayTaskCard(plant, isCompleted);
                },
                childCount: _todayTasks.length,
              ),
            ),

          SliverToBoxAdapter(child: const SizedBox(height: 24)),

          // Upcoming Care Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Upcoming Care",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox(height: 16)),

          // Upcoming Care List
          if (_upcomingCare.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("No upcoming care scheduled", style: TextStyle(color: Colors.black54, fontSize: 14)),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final plant = _upcomingCare[index];
                  return _buildUpcomingCareCard(plant);
                },
                childCount: _upcomingCare.length,
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      // ✅ Floating Action Button connected to Add Reminder Screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReminderScreen(allPlants: widget.allPlants),
            ),
          );
        },
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildTodayTaskCard(UserPlant plant, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? Colors.green.withOpacity(0.3) : Colors.grey.shade200,
          width: isCompleted ? 2 : 1,
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _toggleTaskCompletion(plant.name),
            child: Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.buttonColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: isCompleted ? AppColors.buttonColor : Colors.grey.shade400, width: 2),
              ),
              child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.reminderText.split('•').first.trim(),
                  style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600,
                    color: isCompleted ? Colors.grey : AppColors.primaryText,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${plant.location} • ${plant.reminderText.contains('•') ? plant.reminderText.split('•').last.trim() : ''}",
                  style: TextStyle(fontSize: 13, color: isCompleted ? Colors.grey.shade400 : Colors.black54),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _toggleTaskCompletion(plant.name),
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.buttonColor : Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.check, color: isCompleted ? Colors.white : AppColors.buttonColor, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingCareCard(UserPlant plant) {
    final daysUntil = plant.nextCareDate.difference(DateTime.now()).inDays;
    String dateText = daysUntil == 0 ? "Today" : (daysUntil == 1 ? "Tomorrow" : "In $daysUntil days");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.lightGreenCard, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.water_drop_outlined, color: AppColors.buttonColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.reminderText.split('•').first.trim(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primaryText)),
                const SizedBox(height: 4),
                Text(plant.location, style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(dateText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.buttonColor)),
              const SizedBox(height: 4),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}