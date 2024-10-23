import 'package:flutter/material.dart';

class Award {
  final String name;
  final String description;
  final int pointsRequired;
  final IconData icon;
  final String? imagePath;

  const Award({
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.icon,
    this.imagePath,
  });
}

const List<Award> predefinedAwards = [
  Award(
    name: 'Super Recycler',
    description: 'Complete your first quiz',
    pointsRequired: 20,
    icon: Icons.recycling,
  ),
  Award(
    name: 'E-Waste Master',
    description: 'Complete 10 levels',
    pointsRequired: 100,
    icon: Icons.star_border_purple500_rounded,
  ),
  Award(
    name: 'Point Getter',
    description: 'Earn 500 points',
    pointsRequired: 500,
    icon: Icons.redeem_rounded,
  ),
];

class AwardsPage extends StatelessWidget {
  final ValueNotifier<int> userPoints;
  final List<Award> awards;

  const AwardsPage({
    super.key, 
    required this.userPoints,
    this.awards = predefinedAwards, // Now this is valid since predefinedAwards is constant
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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.stars),
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: awards.length,
        itemBuilder: (context, index) {
          final award = awards[index];
          final bool isUnlocked = award.pointsRequired <= userPoints.value;
          
          return Card(
            child: InkWell(
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
                padding: const EdgeInsets.all(8.0),
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
                        : '${award.pointsRequired} points needed',
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
            isUnlocked ? award.icon : Icons.lock,
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