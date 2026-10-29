import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alerts"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          Card(
            color: Colors.red.shade50,
            child: const ListTile(
              leading: Icon(
                Icons.warning,
                color: Colors.red,
                size: 35,
              ),

              title: Text(
                "Low Stock",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                "Oil is running low (800 ml left)",
              ),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            color: Colors.orange.shade50,
            child: const ListTile(
              leading: Icon(
                Icons.notifications_active,
                color: Colors.orange,
                size: 35,
              ),

              title: Text(
                "Refill Reminder",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                "Buy Milk before tomorrow.",
              ),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            color: Colors.blue.shade50,
            child: const ListTile(
              leading: Icon(
                Icons.wifi,
                color: Colors.blue,
                size: 35,
              ),

              title: Text(
                "ESP32 Status",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                "Device Connected Successfully",
              ),
            ),
          ),

        ],
      ),
    );
  }
}