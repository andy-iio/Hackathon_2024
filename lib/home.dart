import 'package:flutter/material.dart';
import '../Widgets/AppBarWidget.dart';
import '../Widgets/CategoryWidget.dart';
import '../Widgets/DrawerWidget.dart';

class Home extends StatelessWidget {
  final Function(int) navigateToPage;
  final ValueNotifier<int> userPoints = ValueNotifier<int>(0);  //ValueNotifier holds 1 int value and lets you listen to changes to that value, for when they get more points in a quiz

  Home({super.key, required this.navigateToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const AppBarWidget(),
          CategoryWidget(userPoints: userPoints, navigateToPage: navigateToPage),
        ],
      ),
      drawer: DrawerWidget(),
    );
  }
}