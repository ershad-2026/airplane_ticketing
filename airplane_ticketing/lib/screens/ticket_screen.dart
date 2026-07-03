import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Ticket"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.airplane_ticket,
                  size: 80,
                  color: Colors.blue,
                ),

                const SizedBox(height: 20),

                const Text(
                  "BOARDING PASS",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(height: 30),

                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Passenger"),
                  subtitle: Text("Md Ershad"),
                ),

                const ListTile(
                  leading: Icon(Icons.flight_takeoff),
                  title: Text("Route"),
                  subtitle: Text("Dhaka → Dubai"),
                ),

                const ListTile(
                  leading: Icon(Icons.event_seat),
                  title: Text("Seat"),
                  subtitle: Text("A12"),
                ),

                const ListTile(
                  leading: Icon(Icons.calendar_month),
                  title: Text("Date"),
                  subtitle: Text("15 July 2026"),
                ),

                const ListTile(
                  leading: Icon(Icons.confirmation_number),
                  title: Text("Booking ID"),
                  subtitle: Text("AT20260001"),
                ),

                const SizedBox(height: 20),

                const Icon(
                  Icons.qr_code,
                  size: 120,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text("Back to Home"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}