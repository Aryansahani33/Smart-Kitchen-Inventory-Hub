import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  Color getStatusColor(String quantity) {
    if (quantity.contains("0")) {
      return Colors.red;
    } else if (quantity.contains("1") || quantity.contains("2")) {
      return Colors.orange;
    }
    return Colors.green;
  }

  String getStatus(String quantity) {
    if (quantity.contains("0")) {
      return "Critical";
    } else if (quantity.contains("1") || quantity.contains("2")) {
      return "Low Stock";
    }
    return "Sufficient";
  }

  @override
  Widget build(BuildContext context) {
    final items = InventoryData.items;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Stock Alerts",
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
              "Inventory Alerts",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Monitor critical stock levels in real time",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.wifi, color: Colors.white),
                ),
                title: Text(
                  "ESP32 Device",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Connected via Wi-Fi"),
                trailing: Icon(Icons.check_circle, color: Colors.green),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Current Stock Alerts",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,

              itemBuilder: (context, index) {
                final item = items[index];

                final color = getStatusColor(item["quantity"]);

                final status = getStatus(item["quantity"]);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 15),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(18),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: color.withOpacity(0.15),
                              child: Icon(item["icon"], color: color),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    "Current Stock : ${item["quantity"]}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.lightbulb_outline, color: color),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  status == "Critical"
                                      ? "Immediate restocking required to avoid stock-out."
                                      : status == "Low Stock"
                                      ? "Plan a refill soon to maintain inventory."
                                      : "Stock level is healthy. No action required.",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

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
                    Icon(Icons.info_outline, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "In the final IoT version, alerts will be generated automatically based on live weight data received from the ESP32 and load cell.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
