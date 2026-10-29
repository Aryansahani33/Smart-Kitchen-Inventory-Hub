import 'package:flutter/material.dart';
import '../data/inventory_data.dart';
import 'add_item_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Map<String, dynamic>> get inventory => InventoryData.items;

  Future<void> openAddItem() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddItemScreen(),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    int lowStock = inventory
        .where((item) => item["quantity"].toString().contains("0"))
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Kitchen"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Welcome 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: dashboardCard(
                    "Total Items",
                    inventory.length.toString(),
                    Icons.inventory,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: dashboardCard(
                    "Low Stock",
                    lowStock.toString(),
                    Icons.warning,
                    Colors.red,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Inventory",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inventory.length,

              itemBuilder: (context, index) {

                final item = inventory[index];

                return Card(
                  child: ListTile(

                    leading: Icon(
                      item["icon"],
                      color: Colors.green,
                    ),

                    title: Text(item["name"]),

                    subtitle: const Text("Available"),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(
                          item["quantity"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              InventoryData.items.removeAt(index);
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Item Deleted"),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: openAddItem,
                icon: const Icon(Icons.add),
                label: const Text("Add Item"),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
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

            Icon(
              icon,
              color: color,
              size: 40,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(title),

          ],
        ),
      ),
    );
  }
}