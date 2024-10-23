import 'package:flutter/material.dart';

class Award {
  final String name;
  final String description;
  final int pointsRequired; //needed to unlock
  final IconData icon; 

  const Award({
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.icon,
  });
}

//awards to win, all are based on points rn, thats fine for our demo but if time we can change
const List<Award> awardsList = [
  Award(
    name: 'Quiz Rookie',
    description: 'Complete your first quiz',
    pointsRequired: 20,
    icon: Icons.fact_check_rounded,
  ),

    Award(
    name: 'News Master',
    description: 'Read an article on the news tab',
    pointsRequired: 600,
    icon: Icons.star_border_purple500_rounded,
  ),
  Award(
    name: 'Sustainable Superstar',
    description: 'Schedule your first E-waste pickup',
    pointsRequired: 500,
    icon: Icons.recycling,
  ),
    Award(
    name: 'E-Waste Ambassador',
    description: 'Complete 5 quizzes',
    pointsRequired: 100,
    icon: Icons.laptop_chromebook_outlined,
  ),
  Award(
    name: 'Green Champion',
    description: 'Share the app with your friends',
    pointsRequired: 2000,
    icon: Icons.energy_savings_leaf,
  ),
      Award(
    name: 'Badge of Honour',
    description: 'Complete 50 quizzes',
    pointsRequired: 1000,
    icon: Icons.gpp_good_sharp,
  ),
];

class AwardsPage extends StatelessWidget {
  final ValueNotifier<int> userPoints;
  final List<Award> awards;

  const AwardsPage({
    super.key, 
    required this.userPoints,
    this.awards = awardsList, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awards'),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: userPoints,
            builder: (context, points, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0), //for the points on the top bar
                child: Row(
                  children: [
                    const Icon(Icons.stars), //in top bar
                    const SizedBox(width: 4),
                    Text('$points pts'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( //see info here: https://api.flutter.dev/flutter/rendering/SliverGridDelegateWithFixedCrossAxisCount-class.html?gad_source=1&gclid=Cj0KCQjwveK4BhD4ARIsAKy6pMKk8V3nNV5yvrhGbRyQCBI1SWKne2U4LNeDhD6v53qq4yLdfYJmHZcaAufhEALw_wcB&gclsrc=aw.ds
          crossAxisCount: 2, //2 is the max that fit
          childAspectRatio: 0.8, //length of the container
          crossAxisSpacing: 16, //spacing bt containers 
          mainAxisSpacing: 16, //spacing bt containers 
        ),
        itemCount: awards.length,
        itemBuilder: (context, index) {
          final award = awards[index];
          final bool isUnlocked = award.pointsRequired <= userPoints.value;
          
          return Card(
            child: InkWell( //info for inkwell: https://api.flutter.dev/flutter/material/InkWell-class.html?gad_source=1&gclid=Cj0KCQjwveK4BhD4ARIsAKy6pMKqEdMOtAdDcQxQ9GLrtY02ZzOigfnnRwN5OcgToxhyXr08eygM_GkaAgsqEALw_wcB&gclsrc=aw.ds
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AwardDetailsDialog(
                    award: award,
                    isUnlocked: isUnlocked,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0), //padding for the words 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isUnlocked ? award.icon : Icons.lock, 
                      size: 48,
                      color: isUnlocked ? Colors.amber : Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      award.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isUnlocked 
                        ? 'Unlocked!' 
                        : award.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//the dialog box when the award is clicked on
class AwardDetailsDialog extends StatelessWidget {
  final Award award;
  final bool isUnlocked;

  const AwardDetailsDialog({
    super.key,
    required this.award,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(award.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUnlocked ? award.icon : award.icon, //leaving this pointless line bc we can have this second one be icons.lock if wanted but i think it looks better with the icon now 
            size: 64,
            color: isUnlocked ? Colors.amber : Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(award.description),
          const SizedBox(height: 8),
          Text(
            isUnlocked 
              ? 'Congratulations!' 
              : '${award.pointsRequired} points needed',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isUnlocked ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}