import 'package:flutter/material.dart';

import '../data/inventory_data.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  List<Map<String, dynamic>> get filteredItems {
    if (searchText.isEmpty) {
      return InventoryData.items;
    }

    return InventoryData.items.where((item) {
      final name = item["name"].toString().toLowerCase();

      return name.contains(searchText.toLowerCase());
    }).toList();
  }

  Future<void> openAddItem() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddItemScreen()),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: openAddItem,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Inventory"),
      ),

      appBar: AppBar(
        title: const Text(
          "Inventory",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              controller: searchController,

              decoration: InputDecoration(
                hintText: "Search inventory...",

                prefixIcon: const Icon(Icons.search),

                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();

                          setState(() {
                            searchText = "";
                          });
                        },
                      )
                    : null,

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      "No items found",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 90),

                    itemCount: filteredItems.length,

                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      bool lowStock = item["quantity"].toString().contains("0");

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: lowStock
                                ? Colors.red.shade100
                                : Colors.green.shade100,

                            child: Icon(
                              item["icon"],
                              color: lowStock ? Colors.red : Colors.green,
                            ),
                          ),

                          title: Text(
                            item["name"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          subtitle: Text(
                            "${item["category"]}\n${item["quantity"]}",
                          ),
                          isThreeLine: true,

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EditItemScreen(item: item),
                                    ),
                                  );

                                  setState(() {});
                                },
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("Delete Item"),
                                      content: Text("Delete ${item["name"]}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),

                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              InventoryData.items.remove(item);
                                            });

                                            Navigator.pop(context);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "${item["name"]} deleted",
                                                    ),
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
