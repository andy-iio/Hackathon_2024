import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final List<String> categories = [
    "Find Dropoff Center",
    "Schedule Pickup",
    "E-Waste News",
    "Awards"
    // "Eco Tips", **we dont have these pages 
    // "Recycling Guide",
    // "Take the Quiz",
    // "Impact of E-Waste"
  ];

  final List<String> images = [
"assets/images/collection1.png", //dropoff page // Find Collection Points
    "assets/images/schedule.png", // Schedule Pickup
    "assets/images/guide.png", // Recycling Guide
    "assets/images/quiz.png", // Take the Quiz
    // "assets/images/tips.png", // Eco Tips
    // "assets/images/impact.png", // Impact of E-Waste
  ];

  final ValueNotifier<int> userPoints;
  final Function(int) navigateToPage;

  CategoryWidget({
    super.key, 
    required this.userPoints, 
    required this.navigateToPage
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //added learn section 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GestureDetector(
            onTap: () => navigateToPage(1), //this is the quiz page
            child: Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/quiz.png",
                      height: 100,
                    ),
                    const SizedBox(height: 1),
                    const Text(
                      "Learn",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // Categories grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.95,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final navigationIndexMap = {
                    0: 2, //dropoff page
                    1: 3, //collection page
                    2: 4, //news page
                    3: 5, //awards page
                  };
                  navigateToPage(navigationIndexMap[index]!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3), // Shadow effect
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          images[
                              index], // Fetches the correct image for each category
                          height: 70, // Image height
                        ),
                        const SizedBox(
                            height: 15), // Space between the image and the title
                        Text(
                          categories[index], // Category title
                          style: const TextStyle(
                            fontSize: 16.0, // Font size
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Centers the text
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}