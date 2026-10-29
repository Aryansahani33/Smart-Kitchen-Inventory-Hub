import 'package:flutter/material.dart';

class EditItemScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditItemScreen({
    super.key,
    required this.item,
  });

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController nameController;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.item["name"]);

    quantityController =
        TextEditingController(text: widget.item["quantity"]);
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void saveItem() {
    widget.item["name"] = nameController.text;
    widget.item["quantity"] = quantityController.text;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: "Quantity",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveItem,
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}