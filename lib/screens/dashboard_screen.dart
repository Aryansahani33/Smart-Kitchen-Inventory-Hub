import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/inventory_data.dart';
import '../widgets/stat_card.dart';
import '../widgets/quick_action_card.dart';
import 'add_item_screen.dart';
import 'analytics_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> get inventory => InventoryData.items;

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
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> openAddItem() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddItemScreen()),
    );

    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    int lowStock = inventory
        .where((item) => item["quantity"].toString().contains("0"))
        .length;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Stock Sense",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openAddItem,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Inventory"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome 👋",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "AI & IoT Inventory Monitoring",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: "Items",
                    value: inventory.length.toString(),
                    icon: Icons.inventory_2,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: "Low Stock",
                    value: lowStock.toString(),
                    icon: Icons.warning,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: "Device",
                    value: "Online",
                    icon: Icons.wifi,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: "Inventory Value",
                    value: "₹84.5K",
                    icon: Icons.currency_rupee,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.scale, size: 55, color: Colors.green),
                    const SizedBox(height: 10),
                    const Text(
                      "Live Weight",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${currentWeight.toStringAsFixed(2)} g",
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                QuickActionCard(
                  icon: Icons.add_box,
                  title: "Add",
                  color: Colors.green,
                  onTap: openAddItem,
                ),
                const SizedBox(width: 12),
                QuickActionCard(
                  icon: Icons.analytics,
                  title: "Analytics",
                  color: Colors.deepPurple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AnalyticsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                QuickActionCard(
                  icon: Icons.inventory,
                  title: "Inventory",
                  color: Colors.orange,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Alerts",
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
                  backgroundColor: Colors.red,
                  child: Icon(Icons.warning_amber_rounded, color: Colors.white),
                ),
                title: Text(
                  "Low Stock Alert",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Some inventory items require restocking."),
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
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
                  backgroundColor: Colors.green,
                  child: Icon(Icons.memory, color: Colors.white),
                ),
                title: Text(
                  "IoT Device Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("ESP32 Connected • Ready for Live Monitoring"),
                trailing: Icon(Icons.check_circle, color: Colors.green),
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
                child: Column(
                  children: [
                    Icon(Icons.insights, size: 55, color: Colors.green),
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
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      "Real-time stock monitoring for Restaurants, Hospitals, Warehouses and Retail Stores.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
