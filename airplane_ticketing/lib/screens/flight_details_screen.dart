import 'package:flutter/material.dart';
import 'booking_screen.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.flight,
                size: 90,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                "Dhaka ✈ Dubai",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.flight_takeoff,
                  color: Colors.green,
                ),
                title: Text("Departure"),
                subtitle: Text("10:00 AM"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.flight_land,
                  color: Colors.red,
                ),
                title: Text("Arrival"),
                subtitle: Text("2:30 PM"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.event_seat,
                  color: Colors.orange,
                ),
                title: Text("Available Seats"),
                subtitle: Text("25 Seats"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.attach_money,
                  color: Colors.blue,
                ),
                title: Text("Ticket Price"),
                subtitle: Text("120 OMR"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.business,
                  color: Colors.purple,
                ),
                title: Text("Airline"),
                subtitle: Text("Bangladesh Airlines"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.luggage,
                  color: Colors.brown,
                ),
                title: Text("Baggage"),
                subtitle: Text("30 KG Check-in + 7 KG Cabin"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                title: Text("Flight Rating"),
                subtitle: Text("4.8 / 5"),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.airplane_ticket),
                label: const Text(
                  "Book Now",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}