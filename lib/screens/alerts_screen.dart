import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
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

  String getAlert() {
    if (currentWeight < 100) {
      return "Low Container Level";
    } else if (currentWeight < 500) {
      return "Container Half Full";
    } else {
      return "Container Full";
    }
  }

  Color getColor() {
    if (currentWeight < 100) {
      return Colors.red;
    } else if (currentWeight < 500) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String getMessage() {
    if (currentWeight < 100) {
      return "Container weight is below the minimum threshold. Refill recommended.";
    } else if (currentWeight < 500) {
      return "Container is partially filled.";
    } else {
      return "Container level is normal.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Container Alerts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Smart Container Status",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Real-time monitoring using ESP32 & Load Cell",
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

            const SizedBox(height: 20),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: color.withOpacity(0.15),
                      child: Icon(Icons.inventory_2, size: 40, color: color),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      getAlert(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Current Weight: ${currentWeight.toStringAsFixed(2)} g",
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 15),

                    Text(getMessage(), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Alerts are generated automatically from the live weight received from the ESP32 and Load Cell.",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
