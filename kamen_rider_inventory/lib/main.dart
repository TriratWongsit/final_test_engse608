import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/rider_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RiderProvider()..fetchItems()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamen Rider Inventory',
      theme: ThemeData(
        primaryColor: const Color(0xFF006442), 
        scaffoldBackgroundColor: const Color(0xFFF4F6F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF006442), 
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFD32F2F), 
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F), 
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006442),
          secondary: const Color(0xFFD32F2F), 
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}