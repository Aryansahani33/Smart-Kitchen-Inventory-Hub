import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  double currentWeight = 0.0;
  Timer? timer;

  Future<void> fetchWeight() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.0.105/weight"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          currentWeight = (data["weight"] as num).toDouble();
        });
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();

    fetchWeight();

    timer = Timer.periodic(const Duration(seconds: 1), (_) => fetchWeight());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  double get fillPercent {
    double value = currentWeight / 1000;
    if (value > 1) value = 1;
    if (value < 0) value = 0;
    return value;
  }

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
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 15),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
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

  String recommendation() {
    if (currentWeight < 100) {
      return "Container level is low. Refill recommended.";
    } else if (currentWeight < 500) {
      return "Container is partially filled.";
    } else {
      return "Container level is healthy.";
    }
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
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Container Analytics",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Live IoT Monitoring Dashboard",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                analyticsCard(
                  "Current Weight",
                  "${currentWeight.toStringAsFixed(1)} g",
                  Icons.scale,
                  Colors.green,
                ),

                const SizedBox(width: 12),

                analyticsCard("ESP32", "Online", Icons.wifi, Colors.blue),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                analyticsCard("WiFi", "Connected", Icons.router, Colors.orange),

                const SizedBox(width: 12),

                analyticsCard(
                  "Container",
                  "Active",
                  Icons.inventory_2,
                  Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Container Fill Level",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 18),

            progressTile("Current Fill", fillPercent, Colors.green),

            progressTile("Device Connectivity", 1.0, Colors.blue),

            progressTile("System Health", 1.0, Colors.orange),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.memory, color: Colors.white),
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
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.sync, color: Colors.white),
                ),
                title: const Text(
                  "Last Updated",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(TimeOfDay.now().format(context)),
                trailing: const Icon(Icons.cloud_done, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "System Recommendation",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb, color: Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        recommendation(),
                        style: const TextStyle(fontSize: 15),
                      ),
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
