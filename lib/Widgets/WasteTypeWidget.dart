import 'package:flutter/material.dart';

class WasteTypeWidget extends StatefulWidget {
  final Function(Map<String, int>)? onWasteTypeSelected;

  const WasteTypeWidget({Key? key, this.onWasteTypeSelected}) : super(key: key);

  @override
  WasteTypeWidgetState createState() => WasteTypeWidgetState();
}

class WasteTypeWidgetState extends State<WasteTypeWidget> {
  // Selected items and their quantities are stored here
  Map<String, int> _selectedItems = {};

  final List<Map<String, String>> wasteItems = [
    {"title": "Phone", "image": "assets/images/phone.png"},
    {"title": "Laptop", "image": "assets/images/laptop.png"},
    {"title": "Battery", "image": "assets/images/battery.png"},
    {"title": "Blender", "image": "assets/images/blender.png"},
    {"title": "Fridge", "image": "assets/images/fridge.png"},
    {"title": "Speaker", "image": "assets/images/speaker.png"},
    {"title": "Vending", "image": "assets/images/vending.png"},
  ];

  // Function to reset selected waste types
  void resetSelection() {
    setState(() {
      _selectedItems.clear(); // Clears all selected items
    });
  }

  void _updateSelectedItem(String title, int quantity) {
    setState(() {
      if (quantity > 0) {
        _selectedItems[title] = quantity;
      } else {
        _selectedItems.remove(title);
      }
      widget.onWasteTypeSelected?.call(_selectedItems); // Notify selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemCount: wasteItems.length,
            itemBuilder: (context, index) {
              final item = wasteItems[index];
              final title = item["title"]!;
              final isSelected = _selectedItems.containsKey(title);
              final quantity = _selectedItems[title] ?? 0;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedItems.containsKey(title)) {
                      _selectedItems.remove(title);
                    } else {
                      _selectedItems[title] = 1;
                    }
                    widget.onWasteTypeSelected?.call(_selectedItems);
                  });
                },
                child: _buildWasteTypeItem(
                    item["image"]!, title, isSelected, quantity),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWasteTypeItem(
      String imagePath, String title, bool isSelected, int quantity) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.red.withOpacity(0.8)
                : Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: quantity > 1
                        ? () => _updateSelectedItem(title, quantity - 1)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () => _updateSelectedItem(title, quantity + 1),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
