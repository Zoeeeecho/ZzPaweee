import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class ZzPaweeeApp extends StatelessWidget {
  const ZzPaweeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZzPaweee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.brown,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}