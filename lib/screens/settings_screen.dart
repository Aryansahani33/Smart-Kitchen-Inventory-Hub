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
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "System Settings",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Smart Container Configuration",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            settingTile(
              icon: Icons.inventory_2,
              title: "Container Name",
              subtitle: "Kitchen Storage Container",
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
              icon: Icons.scale,
              title: "Sensor",
              subtitle: "HX711 + Load Cell",
              color: Colors.orange,
            ),

            settingTile(
              icon: Icons.notifications,
              title: "Notifications",
              subtitle: "Weight Alerts Enabled",
              color: Colors.red,
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
              subtitle: "Flutter • ESP32 • HX711",
              color: Colors.teal,
            ),

            settingTile(
              icon: Icons.info,
              title: "Application Version",
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.inventory_2, size: 60, color: Colors.green),

                    SizedBox(height: 15),

                    Text(
                      "Stock Sense",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "IoT Smart Container Monitoring System",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 15),

                    Divider(),

                    SizedBox(height: 10),

                    Text(
                      "This prototype demonstrates real-time weight monitoring using an ESP32, HX711 amplifier, Load Cell, and a Flutter application.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
