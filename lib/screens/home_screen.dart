import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'income/income_page.dart';
import 'pets/pets_page.dart';
import 'owners/owners_page.dart';
import 'bookings/bookings_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final pages = const [
    DashboardPage(),
    IncomePage(),
    BookingsPage(),
    PetsPage(),
    OwnersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments),
            label: 'Income',
          ),
          NavigationDestination(
            icon: Icon(Icons.event),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets),
            label: 'Pets',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Owners',
          ),
        ],
      ),
    );
  }
}