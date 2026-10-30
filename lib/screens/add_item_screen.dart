import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minimumController = TextEditingController();

  String selectedCategory = "Grains";
  String selectedUnit = "Kg";

  final List<String> categories = [
    "Grains",
    "Dairy",
    "Vegetables",
    "Fruits",
    "Beverages",
    "Medical Supplies",
    "Cleaning Supplies",
    "Others",
  ];

  final List<String> units = [
    "Kg",
    "Gram",
    "Litre",
    "ml",
    "Pieces",
    "Boxes",
    "Packets",
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _minimumController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (_nameController.text.trim().isEmpty ||
        _quantityController.text.trim().isEmpty ||
        _minimumController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    InventoryData.items.add({
      "name": _nameController.text.trim(),
      "quantity": "${_quantityController.text.trim()} $selectedUnit",
      "category": selectedCategory,
      "minimumStock": _minimumController.text.trim(),
      "icon": Icons.inventory_2,
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Inventory Added Successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(title: const Text("Add Inventory"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Inventory",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "Fill the details below",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Product Name",
                prefixIcon: Icon(Icons.inventory_2),
              ),
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                prefixIcon: Icon(Icons.category),
              ),
              items: categories.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Quantity",
                      prefixIcon: Icon(Icons.scale),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedUnit,
                    decoration: const InputDecoration(labelText: "Unit"),
                    items: units.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedUnit = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),
            TextField(
              controller: _minimumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Minimum Stock",
                prefixIcon: Icon(Icons.warning_amber_rounded),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _saveItem,
                icon: const Icon(Icons.save),
                label: const Text(
                  "Save Inventory",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "This inventory item will be ready for automatic IoT stock monitoring.",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
