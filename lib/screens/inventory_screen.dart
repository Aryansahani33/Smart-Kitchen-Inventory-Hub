import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
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

  String getStatus() {
    if (currentWeight < 100) {
      return "Low Level";
    } else if (currentWeight < 500) {
      return "Medium";
    } else {
      return "Container Full";
    }
  }

  Color getStatusColor() {
    if (currentWeight < 100) {
      return Colors.red;
    } else if (currentWeight < 500) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Smart Container",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Icon(Icons.inventory_2, size: 70, color: Colors.green),
                    SizedBox(height: 12),
                    Text(
                      "Kitchen Storage Container",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Icon(Icons.scale, size: 60, color: Colors.green),

                    const SizedBox(height: 15),

                    const Text(
                      "Current Weight",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "${currentWeight.toStringAsFixed(2)} g",
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.wifi, color: Colors.green),
                title: const Text("ESP32 Status"),
                trailing: const Text(
                  "Connected",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: getStatusColor()),
                title: const Text("Container Status"),
                trailing: Text(
                  getStatus(),
                  style: TextStyle(
                    color: getStatusColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.update),
                title: const Text("Last Updated"),
                trailing: Text(TimeOfDay.now().format(context)),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: fetchWeight,
                icon: const Icon(Icons.refresh),
                label: const Text("Refresh Weight"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
