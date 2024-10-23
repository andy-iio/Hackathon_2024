import 'package:flutter/material.dart';

//all the pages of our app
import 'awards.dart'; //awards that can be unlocked through playing
import 'dropoff.dart'; //find dropoff locations, through googlemaps api
import 'collection.dart'; //the ewaste collection schedule
import 'profile.dart'; //we could have a stats page too to say like you saved x amt of ewaste from going into the environment based on how many times they dropped stuff off?
import 'quiz.dart'; //main quiz page like duolingo

//FLUTTER KEYWORDS & STUFF TO KNOW
//late: will be assigned later
//final: it can only be assigned once and can't be changed (like const?)
//super.xxx: refers to the superclass of the current class

void main() {
  runApp(const EWasteApp());
}

class EWasteApp extends StatelessWidget {
  const EWasteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Waste Duolingo',
      theme: ThemeData(
        primarySwatch: Colors.pink, //main colour scheme of the app elements
        scaffoldBackgroundColor: Colors.white, // background colour
      ),
      home: const BottomNavigation(), 
    );
  }
}

//main bottom navigation
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedPage = 0; //tracks the current page that is selected
  final ValueNotifier<int> userPoints = ValueNotifier<int>(0); //ValueNotifier holds 1 int value and lets you listen to changes to that value, for when they get more points in a quiz
  //its using the final keyword so that the same instance of valuenotifier is used, the points can still be changed 
  late final List<Widget> _pages; 

  @override
  void initState() {
    super.initState();
    //dont change the order of these pages without also changing the icons and labels order below
    _pages = [
      QuizPathScreen(userPoints: userPoints), //the quiz levels 
      const DropoffPage(),
      const CollectionPage(),
      AwardsPage(userPoints: userPoints),
      const ProfilePage(),
    ];
  }
  @override //was getting weird issues when not using dispose 
  void dispose() {
    userPoints.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,

        //when button is clicked, change the page
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },

        //the icons are so fun: https://api.flutter.dev/flutter/material/Icons-class.html
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Drop-off',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Awards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}