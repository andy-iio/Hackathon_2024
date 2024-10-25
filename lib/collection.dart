import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/WasteTypeWidget.dart';
import '../main.dart'; // for using pickuplist
import 'dart:math';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  Map<String, int> _selectedWasteItems = {};
  bool _isConfirmed = false;
  final GlobalKey<WasteTypeWidgetState> _wasteTypeKey = GlobalKey();

  // Map to hold checkbox states
  Map<String, bool> _selectedDays = {};

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  List<String> _calculateUpcomingCollectionDays() {
    if (_selectedDate == null) {
      return [];
    }

    DateTime nextMonday = _findNextWeekday(_selectedDate!, DateTime.monday);
    DateTime nextWednesday =
        _findNextWeekday(_selectedDate!, DateTime.wednesday);
    DateTime nextFriday = _findNextWeekday(_selectedDate!, DateTime.friday);

    return [
      'Monday, ${DateFormat('MMMM dd, yyyy').format(nextMonday)}',
      'Wednesday, ${DateFormat('MMMM dd, yyyy').format(nextWednesday)}',
      'Friday, ${DateFormat('MMMM dd, yyyy').format(nextFriday)}',
    ];
  }

  DateTime _findNextWeekday(DateTime fromDate, int weekday) {
    DateTime nextDay = fromDate;
    while (nextDay.weekday != weekday) {
      nextDay = nextDay.add(const Duration(days: 1));
    }
    return nextDay;
  }

  void _handleCheckboxChanged(String day, bool? value) {
    if (value == true && _selectedDays.values.where((v) => v).length >= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only select one day'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        _selectedDays = {for (var k in _selectedDays.keys) k: false};
        _selectedDays[day] = value ?? false;
      });
    }
  }

  void _confirmPickup() {
    if (_selectedDate == null || _selectedWasteItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both a date and waste type'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      final selectedDay = _selectedDays.entries
          .where((element) => element.value)
          .map((e) => e.key)
          .toList();

      if (selectedDay.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a collection day'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Generate random ID
        final randomId = Random().nextInt(90000) + 10000; // 10000-99999

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Pickup'),
              content: Text(
                  'Are you sure you want to confirm the pickup on ${selectedDay.first} with ID: $randomId?'),
              actions: [
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the diaglog
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    // Add new pickup to pickupList after user confirmation
                    pickupList.add({
                      "id": randomId, // Random generate ID
                      "date": selectedDay.first,
                      "wasteItems": Map<String, int>.from(_selectedWasteItems),
                      "status": "Confirmed",
                    });

                    setState(() {
                      _isConfirmed = true;
                      _selectedDate = null;
                      _selectedWasteItems = {};
                      _dateController.clear();
                      _selectedDays = {}; // Clear selections

                      // Reset WasteTypeWidget
                      _wasteTypeKey.currentState?.resetSelection();
                    });

                    Navigator.of(context).pop(); // Close dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Your e-waste pickup has been confirmed for: ${selectedDay.join(", ")} with ID: $randomId. You can view details in the "My Pickups" section.'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final upcomingDays = _calculateUpcomingCollectionDays();

    _selectedDays = {
      for (var day in upcomingDays) day: _selectedDays[day] ?? false,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection Schedule'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedDate == null)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.redAccent.withOpacity(0.1),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Please select a date to view the weekly collection schedule.",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Pickup Date',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Select a date',
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedDate != null) ...[
              const Text(
                'Upcoming Collection Days:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Column(
                children: upcomingDays.map((day) {
                  return CheckboxListTile(
                    title: Text(day),
                    value: _selectedDays[day] ?? false,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) => _handleCheckboxChanged(day, value),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 20),
            WasteTypeWidget(
              key: _wasteTypeKey,
              onWasteTypeSelected: (Map<String, int> selectedItems) {
                setState(() {
                  _selectedWasteItems = selectedItems;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmPickup,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Confirm Pickup',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
