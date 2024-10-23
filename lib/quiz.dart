import 'package:flutter/material.dart';
import 'dart:math';
import 'levels.dart';

class QuizPathScreen extends StatefulWidget {
  final ValueNotifier<int> userPoints;

  const QuizPathScreen({
    super.key,
    required this.userPoints,
  });


  @override
  State<QuizPathScreen> createState() => _QuizPathScreenState();
}

class _QuizPathScreenState extends State<QuizPathScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F7),
      appBar: AppBar(
        title: const Text('E-Waste Duolingo'), //header title
        backgroundColor: const Color.fromARGB(255, 246, 159, 221), //header colour
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: widget.userPoints,
            builder: (context, points, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0), //can change the padding to make it look better
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
      body: SingleChildScrollView( //see this link: https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html?gad_source=1&gclid=Cj0KCQjwveK4BhD4ARIsAKy6pMJVZvPz8a-phtL-CS9-DaD-md_QColwbxbjN4N79MqFOhBFMgvm3eAaAu6pEALw_wcB&gclsrc=aw.ds
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width, //just keeping the og width for now
              height: 2000, //looks best on my screen at 2000 but if we test on an actual phone this probs needs to change
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/download.jpg'), //we gotta change the bg image it looks kinda weird 
                  repeat: ImageRepeat.repeatY,
                  fit: BoxFit.fitWidth, //theres other options for fit to try we can check which is best 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              height: 1200,
              child: _buildLevelsPath(),
            ),
          ],
        ),
      ),
    );
  }

//to make the path the levels follow
  Widget _buildLevelsPath() {
    return Stack(
      children: List.generate(levels.length, (index) {
        final xOffset = sin(index * 0.5) * 50 + 150;  //the path of the q's, using sin for nice wavey-ness
        final yOffset = index * 70.0 + 50; //i think using matlab and making a path based on our background is the best way to model this

        return Positioned(
          left: xOffset,
          top: yOffset,
          child: LevelButton(
            level: levels[index],
            onTap: () {
              if (levels[index].isUnlocked) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelPage(
                      level: levels[index],
                      onComplete: (points) {
                        setState(() {
                          widget.userPoints.value += points;
                          levels[index].isCompleted = true;
                          //stars based on points (1 right q = 1 star) ** based on 2 q;s per level - i think we could make this dynamic so it checks how many q's in the level but im tired lol
                          levels[index].score = (points / 20 * 3).round();
                          
                          //unlock next level if they have enough points
                          if (index + 1 < levels.length &&
                              widget.userPoints.value >= levels[index + 1].pointsToUnlock) {
                            levels[index + 1].isUnlocked = true;
                          }
                        });
                      },
                    ),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

class LevelButton extends StatelessWidget {
  final Level level;
  final VoidCallback onTap;

  const LevelButton({
    super.key,
    required this.level,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( //here: https://api.flutter.dev/flutter/widgets/GestureDetector-class.html?gad_source=1&gclid=Cj0KCQjwveK4BhD4ARIsAKy6pMLEqRmPB6iZQgKY30T_-Cl2qjqpjmC8v63wEBxuddoV8DVyvjPUzuMaAlpbEALw_wcB&gclsrc=aw.ds
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !level.isUnlocked ? Colors.grey : Colors.white, //when locked circle colours
          border: Border.all(
            color: level.isCompleted 
                ? Colors.green 
                : level.isUnlocked 
                    ? const Color.fromARGB(255, 226, 149, 241) //unlocked but not yet completed
                    : Colors.grey.shade600,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26, //to make it stand out against the bg
              offset: const Offset(0, 2),
              blurRadius: 6, //can be made bigger
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${level.id}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: !level.isUnlocked 
                      ? Colors.white
                      : level.isCompleted 
                          ? Colors.green 
                          : const Color.fromARGB(255, 226, 149, 241) ,
                ),
              ),
              if (level.score > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Icon(
                      index < level.score ? Icons.star : Icons.star_border, //i love the icons so fun
                      size: 12,
                      color: const Color.fromARGB(255, 254, 202, 45),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        title: Text('Level ${widget.level.id}: ${widget.level.title}'),
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

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar( //cool name,, this is the little dialouge at the bottom of the screen
                            content: Text(
                              quiz.isCorrect ? 'Correct! +10 points' : 'Incorrect',
                            ),
                            duration: const Duration(seconds: 1), //go away after 1 sec
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
                          : Colors.red
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