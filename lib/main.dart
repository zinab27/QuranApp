import 'package:flutter/material.dart';
import 'package:quran/widgets/home_page.dart';

void main() {
  runApp(const MyApp());
}

var myColor =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 183, 71));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
            appBarTheme: const AppBarTheme().copyWith(
              color: myColor.primary,
              centerTitle: true,
            ),
            colorScheme: myColor,
            textTheme: const TextTheme().copyWith(
              bodyMedium: const TextStyle().copyWith(
                fontSize: 20,
                color: Colors.black,
              ),
            )),
        home: const HomePage(),
      ),
    );
  }
}
