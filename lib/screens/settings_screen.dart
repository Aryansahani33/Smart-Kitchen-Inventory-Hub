import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;

  Widget settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    Widget? trailing,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: trailing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Application Settings",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Stock Sense Configuration",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            settingTile(
              icon: Icons.business,
              title: "Organization",
              subtitle: "Restaurant / Hospital / Warehouse",
              color: Colors.blue,
            ),

            settingTile(
              icon: Icons.person,
              title: "Developer",
              subtitle: "Aryan & Harsh",
              color: Colors.green,
            ),

            settingTile(
              icon: Icons.wifi,
              title: "Wi-Fi Status",
              subtitle: "Connected",
              color: Colors.blue,
            ),

            settingTile(
              icon: Icons.memory,
              title: "ESP32 Device",
              subtitle: "Online",
              color: Colors.deepPurple,
            ),

            settingTile(
              icon: Icons.notifications,
              title: "Notifications",
              subtitle: "Low stock alerts enabled",
              color: Colors.orange,
              trailing: Switch(
                value: notifications,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
            ),
            settingTile(
              icon: Icons.code,
              title: "Technology",
              subtitle: "Flutter • Dart • ESP32 • HX711 • Load Cell",
              color: Colors.teal,
            ),

            settingTile(
              icon: Icons.info,
              title: "Version",
              subtitle: "Stock Sense v1.0",
              color: Colors.indigo,
            ),

            const SizedBox(height: 25),

            Card(
              color: Colors.green.shade50,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    Icon(Icons.inventory_2, color: Colors.green, size: 55),
                    SizedBox(height: 12),
                    Text(
                      "Stock Sense",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "AI & IoT Based Smart Inventory Management System",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 8),
                    Text(
                      "Designed for Restaurants, Hospitals, Warehouses & Retail Stores",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
