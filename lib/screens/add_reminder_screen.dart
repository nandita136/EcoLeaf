import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import '../../resources/colors_resource.dart';
import 'user_plant_details_screen.dart'; // For UserPlant model

class AddReminderScreen extends StatefulWidget {
  final List<UserPlant> allPlants;

  const AddReminderScreen({super.key, required this.allPlants});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  UserPlant? _selectedPlant;
  final TextEditingController _taskController = TextEditingController();
  
  // Default to tomorrow at 9:00 AM
  DateTime? _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay? _selectedTime = const TimeOfDay(hour: 9, minute: 0);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.buttonColor, // Header background
              onPrimary: Colors.white, // Header text
              onSurface: AppColors.primaryText, // Body text
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.buttonColor, // Selected time color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveReminder() {
    if (_selectedPlant == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a plant'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_taskController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a reminder task'), backgroundColor: Colors.red),
      );
      return;
    }

    // Format the final reminder string (e.g., "Water • Tomorrow, Oct 15 • 9:00 AM")
    final String dateStr = DateFormat('MMM d').format(_selectedDate!);
    final String timeStr = _selectedTime!.format(context);
    final String fullReminder = "${_taskController.text.trim()} • $dateStr • $timeStr";

    // In a full app, you would update the plant's reminder data here.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder set for $fullReminder'),
        backgroundColor: AppColors.buttonColor,
      ),
    );
    
    // Pop back to the reminders screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
          'Add Reminder',
          style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set a care task for your plant',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // 1. Select Plant Dropdown
            const Text(
              'Select Plant',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryText),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<UserPlant>(
                  isExpanded: true,
                  hint: const Text('Choose a plant...', style: TextStyle(color: Colors.grey)),
                  value: _selectedPlant,
                  items: widget.allPlants.map((plant) {
                    return DropdownMenuItem<UserPlant>(
                      value: plant,
                      child: Text(plant.name, style: const TextStyle(color: AppColors.primaryText)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPlant = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Reminder Task Input
            const Text(
              'Reminder Task',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryText),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  hintText: 'e.g., Water, Mist, Fertilize',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Date Picker
            const Text(
              'Reminder Date',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryText),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, color: AppColors.buttonColor, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _selectedDate != null 
                          ? DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate!) 
                          : 'Select Date',
                      style: TextStyle(
                        color: _selectedDate != null ? AppColors.primaryText : Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Time Picker
            const Text(
              'Reminder Time',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryText),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_outlined, color: AppColors.buttonColor, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _selectedTime != null 
                          ? _selectedTime!.format(context) 
                          : 'Select Time',
                      style: TextStyle(
                        color: _selectedTime != null ? AppColors.primaryText : Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 5. Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _saveReminder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Reminder',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}