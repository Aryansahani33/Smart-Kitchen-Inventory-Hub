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

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _saveItem() {
  if (_nameController.text.trim().isEmpty ||
      _quantityController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all fields"),
      ),
    );
    return;
  }

  InventoryData.items.add({
    "name": _nameController.text.trim(),
    "quantity": _quantityController.text.trim(),
    "category": "Added Item",
    "icon": Icons.inventory,
  });

  Navigator.pop(context);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Item Added Successfully"),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.fastfood),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.scale),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveItem,
                icon: const Icon(Icons.add),
                label: const Text("Save Item"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}