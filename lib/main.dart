import 'package:flutter/material.dart';

//all the pages of our app
import 'awards.dart'; //awards that can be unlocked through playing
import 'dropoff.dart'; //find dropoff locations, through googlemaps api
import 'collection.dart'; //the ewaste collection schedule
import 'profile.dart'; //we could have a stats page too to say like you saved x amt of ewaste from going into the environment based on how many times they dropped stuff off?
import 'quiz.dart'; //main quiz page like duolingo
import 'news.dart'; //news articles and stuff

//FLUTTER KEYWORDS & STUFF TO KNOW
//late: will be assigned later
//final: it can only be assigned once and can't be changed (like const?)
//super.xxx: refers to the superclass of the current class

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //makes sure the webview gets initalized (used for newspage)
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

//main bottom navigation menu
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
      NewsPage(),
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
            icon: Icon(Icons.newspaper_rounded),
            label: 'News',
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