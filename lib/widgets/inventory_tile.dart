import 'package:flutter/material.dart';

class InventoryTile extends StatelessWidget {
  final String name;
  final String quantity;
  final IconData icon;
  final bool lowStock;
  final VoidCallback onDelete;

  const InventoryTile({
    super.key,
    required this.name,
    required this.quantity,
    required this.icon,
    required this.lowStock,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: CircleAvatar(
          radius: 24,
          backgroundColor: (lowStock ? Colors.red : Colors.green).withOpacity(
            0.15,
          ),
          child: Icon(icon, color: lowStock ? Colors.red : Colors.green),
        ),

        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Icon(
                lowStock ? Icons.warning : Icons.check_circle,
                size: 16,
                color: lowStock ? Colors.red : Colors.green,
              ),
              const SizedBox(width: 5),
              Text(
                lowStock ? "Low Stock" : "Healthy Stock",
                style: TextStyle(
                  color: lowStock ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quantity,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
