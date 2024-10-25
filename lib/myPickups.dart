import 'package:flutter/material.dart';
import '../main.dart'; // Importing pickupList

class MyPickups extends StatelessWidget {
  MyPickups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pickups'),
      ),
      body: pickupList.isEmpty // If pickupList is empty
          ? Center(
              child: Text(
                'You have no pickups scheduled yet.\nSchedule a pickup to see it here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: pickupList.length,
              itemBuilder: (context, index) {
                final pickup = pickupList[index];
                final wasteItems = pickup["wasteItems"] as Map<String, int>;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pickup ID: ${pickup['id']}", // Displaying ID
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              pickup['status'],
                              style: TextStyle(
                                color: pickup['status'] == "Confirmed"
                                    ? Colors.green
                                    : pickup['status'] == "Pending"
                                        ? Colors.orange
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("Date:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(pickup['date']), // Displaying date
                        const SizedBox(height: 8),
                        const Text("Waste Items:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        ...wasteItems.entries.map(
                            (entry) => Text("${entry.key}: ${entry.value}")),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
