import 'package:flutter/material.dart';
import 'bottomNav.dart';
//FLUTTER KEYWORDS & STUFF TO KNOW
//late: will be assigned later
//final: it can only be assigned once and can't be changed (like const?)
//super.xxx: refers to the superclass of the current class

void main() {
  runApp(const EWasteApp());
}

class EWasteApp extends StatelessWidget {
  const EWasteApp({super.key});

//!!!!!!!!!!!!!!!!!!!!!
//THEME FOR OVERALL APP!
//more info here: https://docs.flutter.dev/cookbook/design/themes?gad_source=1&gclid=Cj0KCQjwveK4BhD4ARIsAKy6pMLW8BF8ezkmhM_R31ptPvqpAkU5dBEtcyZHJgRselT3uB-2T_J2E1AaAhUEEALw_wcB&gclsrc=aw.ds
//there is a way to use google fonts but idk how yet
//!!!!!!!!!!!!!!!!!!!!!

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Waste Duolingo', //we need to come up with a name 
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), //main colour scheme of the app elements
        scaffoldBackgroundColor: Colors.white, // background colour
        textTheme: TextTheme(
        titleLarge: const TextStyle( //used in main topbar headings 
          fontSize: 24,
          fontWeight: FontWeight.bold,
          ),
        headlineSmall: const TextStyle( //used in questions for quiz 
          fontSize: 28, 
          ),
        ),
      ),
      home: const BottomNavigation(), 
    );
  }
}