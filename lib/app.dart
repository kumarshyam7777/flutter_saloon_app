import 'package:flutter/material.dart';

import 'screens/home_page.dart';

class SalonApp extends StatelessWidget {
  const SalonApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearby Salons',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const HomePage(),
    );
  }
}
