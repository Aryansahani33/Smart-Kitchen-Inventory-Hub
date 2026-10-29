import 'package:flutter/material.dart';
import '../models/inventory_item.dart';

class InventoryProvider {

  static List<InventoryItem> items = [

    InventoryItem(
      name: "Rice",
      quantity: "5 Kg",
      category: "Grains",
      icon: Icons.rice_bowl,
      minStock: 2,
    ),

    InventoryItem(
      name: "Sugar",
      quantity: "2 Kg",
      category: "Groceries",
      icon: Icons.cookie,
      minStock: 1,
    ),

    InventoryItem(
      name: "Oil",
      quantity: "800 ml",
      category: "Cooking",
      icon: Icons.water_drop,
      minStock: 500,
    ),

    InventoryItem(
      name: "Milk",
      quantity: "1 L",
      category: "Dairy",
      icon: Icons.local_drink,
      minStock: 1,
    ),

  ];

}