import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  int get totalItems => InventoryData.items.length;

  int get lowStock => InventoryData.items
      .where((item) => item["quantity"].toString().contains("0"))
      .length;

  Widget analyticsCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 28),
              ),

              const SizedBox(height: 15),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progressTile(String title, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text("${(value * 100).toInt()}%"),
            ],
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: value,
            color: color,
            minHeight: 10,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Analytics",
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
              "Inventory Overview",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Real-time business insights",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                analyticsCard(
                  "Total Items",
                  totalItems.toString(),
                  Icons.inventory_2,
                  Colors.green,
                ),

                const SizedBox(width: 12),

                analyticsCard(
                  "Low Stock",
                  lowStock.toString(),
                  Icons.warning,
                  Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                analyticsCard("IoT Device", "Online", Icons.wifi, Colors.blue),

                const SizedBox(width: 12),

                analyticsCard(
                  "Inventory",
                  "₹84.5K",
                  Icons.currency_rupee,
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Inventory Health",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 18),
            progressTile("Inventory Health", 0.90, Colors.green),

            progressTile("IoT Connectivity", 1.00, Colors.blue),

            progressTile("Stock Availability", 0.82, Colors.orange),

            const SizedBox(height: 25),

            const Text(
              "System Status",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.router, color: Colors.white),
                ),
                title: Text(
                  "ESP32 Device",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Connected via Wi-Fi"),
                trailing: Icon(Icons.check_circle, color: Colors.green),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.sync, color: Colors.white),
                ),
                title: Text(
                  "Last Synchronization",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Just now"),
                trailing: Icon(Icons.cloud_done, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "AI Recommendations",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Based on current inventory trends, consider restocking low-stock items before they reach critical levels. Future versions will use IoT data to generate automatic recommendations.",
                        style: TextStyle(fontSize: 15),
                      ),
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
