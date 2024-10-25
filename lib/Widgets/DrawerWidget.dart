import 'package:flutter/material.dart';
import '../profile.dart';
import '../myPickups.dart'; // Importing MyPickups page

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              accountName: Text(
                "Mary Jones",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "maryjones@gmail.com",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user3.png'),
              ),
            ),
          ),

          // List Tile for Home
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(
                  context); // Close the drawer and stay on the HomePage
            },
          ),

          // List Tile for My Account (Navigating to Profile Page)
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: const Text(
              "My Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),

          // List Tile for Settings
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            title: const Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigation to Settings page can be implemented here
            },
          ),

          // List Tile for My Pickup (Navigating to MyPickups page)
          ListTile(
            leading: const Icon(
              Icons.recycling,
              color: Colors.green,
            ),
            title: const Text(
              "My Pickup",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPickups(),
                ),
              );
            },
          ),

          // List Tile for Log Out
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.green,
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Log Out functionality can be implemented here
            },
          ),
        ],
      ),
    );
  }
}
