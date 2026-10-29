import 'package:flutter/material.dart';

class InventoryItem {
  String name;
  String quantity;
  String category;
  IconData icon;
  DateTime? expiryDate;
  double minStock;

  InventoryItem({
    required this.name,
    required this.quantity,
    required this.category,
    required this.icon,
    this.expiryDate,
    this.minStock = 1,
  });
}
