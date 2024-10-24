import 'package:flutter/material.dart';

//all the pages of our app
import 'awards.dart'; //awards that can be unlocked through playing
import 'dropoff.dart'; //find dropoff locations, through googlemaps api
import 'collection.dart'; //the ewaste collection schedule
import 'quiz.dart'; //main quiz page like duolingo
import 'news.dart'; //news articles and stuff
import 'home.dart';

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
      Home(navigateToPage: _navigateToPage),
      QuizPathScreen(userPoints: userPoints), //the quiz levels 
      DropoffPage(),
      const CollectionPage(),
      NewsPage(),
      AwardsPage(userPoints: userPoints),
    ];
  }

  void _navigateToPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override //was getting weird issues when not using dispose 
  void dispose() {
    userPoints.dispose();
    super.dispose();
  }

//the icons are so fun: https://api.flutter.dev/flutter/material/Icons-class.html
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: _navigateToPage, //when button is clicked, change the page
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
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
        ],
      ),
    );
  }
}