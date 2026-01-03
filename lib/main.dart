import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.lightBlueAccent;

    const Color darkBackground = Color(0xFF121212);

    return MaterialApp(
      title: 'YOLO Dark Mode',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: darkBackground,
        primaryColor: primaryColor,

        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: primaryColor,
          surface: Color(0xFF1E1E1E),
          onPrimary: Colors.black,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
        ),

        iconTheme: const IconThemeData(color: primaryColor),
      ),
      home: const HomeScreen(),
    );
  }
}
