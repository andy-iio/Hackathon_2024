import 'package:flutter/material.dart';

//maybe the classes should be in their own file idk 
class Level {
  final int id;
  final String title;
  final String article;
  final List<Quiz> quizzes;
  final int pointsToUnlock;
  bool isUnlocked;
  bool isCompleted;

  Level({
    required this.id,
    required this.title,
    required this.article,
    required this.quizzes,
    required this.pointsToUnlock,
    this.isUnlocked = false,
    this.isCompleted = false,
  });
}

class Quiz {
  final String question;
  final List<String> options;
  final int correctAnswer;
  bool isAnswered;
  bool isCorrect;

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.isAnswered = false,
    this.isCorrect = false,
  });
}

//main page 
class LevelsPage extends StatelessWidget {
  final ValueNotifier<int> userPoints;
  final List<Level> levels = [
    Level(
      id: 1,
      title: 'Introduction to E-Waste',
      article: '''article/ video/ infographic here ''',
      quizzes: [
        Quiz(
          question: 'What is e-waste?',
          options: [
            'Food waste',
            'Electronic waste',
            'Paper waste',
            'Plastic waste'
          ],
          correctAnswer: 1,
        ),
        Quiz(
          question: 'Which of these is e-waste?',
          options: [
            'Newspaper',
            'Broken phone',
            'Food',
            'Clothes'
          ],
          correctAnswer: 1,
        ),
        Quiz(
          question: 'Why is proper e-waste disposal important?',
          options: [
            'Answer 1',
            'It prevents harmful materials from entering the environment',
            'Another answer',
            'Another other answer'
          ],
          correctAnswer: 1,
        ),
      ],
      pointsToUnlock: 0,
      isUnlocked: true,
    ),
    Level(
      id: 2,
      title: 'Environmental Impact',
      article: '''article here''',
      quizzes: [
        Quiz(
          question: 'What harmful substance is found in ewaste?',
          options: [
            '0',
            '1',
            'Lead',
            '3'
          ],
          correctAnswer: 2,
        ),
        Quiz(
          question: 'How does bad e-waste disposal affect the environment?',
          options: [
            'correct answer',
            '1',
            '2',
            '3'
          ],
          correctAnswer: 0,
        ),
      ],
      pointsToUnlock: 20,
    ),
    Level(
      id: 3,
      title: 'Recycling Benefits',
      article: '''article here''',
      quizzes: [
        Quiz(
          question: 'q1?',
          options: [
            '1',
            'right answer',
            '3',
            '4'
          ],
          correctAnswer: 1,
        ),
        Quiz(
          question: 'q2?',
          options: [
            '0',
            '1',
            'right answer',
            '3'
          ],
          correctAnswer: 2,
        ),
      ],
      pointsToUnlock: 40,
    ),
  ];

  LevelsPage({super.key, required this.userPoints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Waste Duolingo'),
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
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          return LevelCard(
            level: level,
            onTap: () {
              if (level.isUnlocked) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelPage(
                      level: level,
                      onComplete: (points) {
                        userPoints.value += points;
                        level.isCompleted = true;
                        //unlock next level
                        if (index + 1 < levels.length &&
                            userPoints.value >= levels[index + 1].pointsToUnlock) {
                          levels[index + 1].isUnlocked = true;
                        }
                      },
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}


class LevelCard extends StatelessWidget {
  final Level level;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 7, 20, 7), //margin around the level cards
      child: ListTile(
        leading: CircleAvatar( //the circle that tells you the lvel number
          backgroundColor: level.isCompleted
              ? Colors.green //green when completed
              : level.isUnlocked
                  ? const Color.fromARGB(255, 209, 155, 242) //purple when unlocked but not yet finished
                  : Colors.grey, //grey when not unlocked yet
          child: Text(level.id.toString()),
        ),
        title: Text(level.title),
        subtitle: Text(
          level.isCompleted
              ? 'Completed!'
              : level.isUnlocked
                  ? 'Tap to start'
                  : '${level.pointsToUnlock} points needed to unlock',
        ),
        trailing: Icon(
          level.isCompleted
              ? Icons.check_circle
              : level.isUnlocked
                  ? Icons.play_circle
                  : Icons.lock,
          color: level.isCompleted //the colour of the play button/lock button when completed/not completed/unlocked
              ? Colors.green
              : level.isUnlocked
                  ? const Color.fromARGB(255, 209, 155, 242)
                  : Colors.grey,
        ),
        onTap: level.isUnlocked ? onTap : null,
      ),
    );
  }
}

//level page
class LevelPage extends StatefulWidget {
  final Level level;
  final Function(int points) onComplete;

  const LevelPage({
    super.key,
    required this.level,
    required this.onComplete,
  });

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  bool showingArticle = true;
  int currentQuizIndex = 0;
  int points = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${widget.level.id}'),
      ),
      body: showingArticle ? _buildArticleView() : _buildQuizView(),
    );
  }

  Widget _buildArticleView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.level.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            widget.level.article,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showingArticle = false;
              });
            },
            child: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizView() {
    final quiz = widget.level.quizzes[currentQuizIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearProgressIndicator(
            value: (currentQuizIndex + 1) / widget.level.quizzes.length,
          ),
          const SizedBox(height: 16),
          Text(
            'Question ${currentQuizIndex + 1}/${widget.level.quizzes.length}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            quiz.question,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          ...List.generate(
            quiz.options.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: quiz.isAnswered
                    ? null
                    : () {
                        setState(() {
                          quiz.isAnswered = true;
                          quiz.isCorrect = index == quiz.correctAnswer;
                          if (quiz.isCorrect) {
                            points += 10;
                          }
                        });

                        //show if correct or incorrect
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              quiz.isCorrect ? 'Correct! +10 points' : 'Incorrect',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );

                        //delay before moving to next question for cool effect
                        Future.delayed(const Duration(seconds: 1), () {
                          if (currentQuizIndex <
                              widget.level.quizzes.length - 1) {
                            setState(() {
                              currentQuizIndex++;
                            });
                          } else {
                            widget.onComplete(points);
                            Navigator.pop(context);
                          }
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: quiz.isAnswered
                      ? index == quiz.correctAnswer
                          ? Colors.green
                          : index == quiz.correctAnswer
                              ? Colors.red
                              : null
                      : null,
                ),
                child: Text(quiz.options[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}