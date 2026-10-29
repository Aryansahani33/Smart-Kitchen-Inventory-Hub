import 'package:flutter/material.dart';
import '../data/inventory_data.dart';
import 'edit_item_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final filteredItems = InventoryData.items.where((item) {
      return item["name"]
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search item...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: Icon(
                      item["icon"],
                      color: Colors.green,
                    ),

                    title: Text(item["name"]),

                    subtitle: Text(item["category"]),

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
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Delete Item"),
            content: Text(
              "Are you sure you want to delete ${item["name"]}?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    InventoryData.items.remove(item);
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Item Deleted"),
                    ),
                  );
                },
                child: const Text("Delete"),
              ),
            ],
          ),
        );
      },
    ),
  ],
),

                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditItemScreen(
                            item: item,
                          ),
                        ),
                      );

                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}