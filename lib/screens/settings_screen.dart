import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Developer"),
            subtitle: Text("Aryan"),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.group),
            title: Text("Project Team"),
            subtitle: Text("Aryan & Harsh"),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.kitchen),
            title: Text("Project"),
            subtitle: Text("Smart Kitchen Inventory Hub"),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.memory),
            title: Text("Hardware"),
            subtitle: Text("ESP32 • HX711 • Load Cell"),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.code),
            title: Text("Technology"),
            subtitle: Text("Flutter • Dart"),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.verified),
            title: Text("Version"),
            subtitle: Text("1.0"),
          ),
        ],
      ),
    );
  }
}