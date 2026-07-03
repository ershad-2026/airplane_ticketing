import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.flight),
            title: Text("Dhaka → Dubai"),
            subtitle: Text("Seat: A12"),
            trailing: Text("120 OMR"),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.flight),
            title: Text("Muscat → Dhaka"),
            subtitle: Text("Seat: B05"),
            trailing: Text("95 OMR"),
          ),
        ],
      ),
    );
  }
}