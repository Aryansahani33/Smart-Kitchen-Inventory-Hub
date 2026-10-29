import 'package:flutter/material.dart';

class InventoryData {
  static List<Map<String, dynamic>> items = [
    {
      "name": "Rice",
      "quantity": "5 Kg",
      "category": "Grains",
      "icon": Icons.rice_bowl,
    },
    {
      "name": "Sugar",
      "quantity": "2 Kg",
      "category": "Groceries",
      "icon": Icons.cookie,
    },
    {
      "name": "Oil",
      "quantity": "800 ml",
      "category": "Cooking",
      "icon": Icons.water_drop,
    },
    {
      "name": "Milk",
      "quantity": "1 L",
      "category": "Dairy",
      "icon": Icons.local_drink,
    },
  ];
}