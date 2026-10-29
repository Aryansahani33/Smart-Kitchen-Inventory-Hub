import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  Widget analyticsCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitchen Analytics"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

                Expanded(
                  child: analyticsCard(
                    "Items",
                    "5",
                    Icons.inventory,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: analyticsCard(
                    "Low Stock",
                    "1",
                    Icons.warning,
                    Colors.red,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: analyticsCard(
                    "Weight",
                    "9.2 Kg",
                    Icons.scale,
                    Colors.orange,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: analyticsCard(
                    "Sensor",
                    "Online",
                    Icons.wifi,
                    Colors.blue,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            const Card(
  child: ListTile(
    leading: Icon(Icons.access_time, color: Colors.green),
    title: Text("Last Updated"),
    subtitle: Text("Today 8:45 PM"),
  ),
),

            const SizedBox(height: 10),

            const Card(
  child: ListTile(
    leading: Icon(Icons.router, color: Colors.blue),
    title: Text("ESP32 Status"),
    subtitle: Text("Connected via Wi-Fi"),
  ),
),

          ],
        ),
      ),
    );
  }
}
