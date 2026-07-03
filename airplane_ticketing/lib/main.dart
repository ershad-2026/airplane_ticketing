import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AirplaneTicketingApp());
}

class AirplaneTicketingApp extends StatelessWidget {
  const AirplaneTicketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Airplane Ticketing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}