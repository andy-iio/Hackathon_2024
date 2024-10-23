class Level {
  final int id;
  final String title;
  final String article;
  final List<Quiz> quizzes;
  final int pointsToUnlock;
  bool isUnlocked;
  bool isCompleted;
  int score; // 0-3 stars

  Level({
    required this.id,
    required this.title,
    required this.article,
    required this.quizzes,
    required this.pointsToUnlock,
    this.isUnlocked = false,
    this.isCompleted = false,
    this.score = 0,
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

//---------------------------------------------------------------------------------------//
// -------------- THE LEVEL INFO (ARTICLES/INFOGRAPHICS/VIDEOS/QUIZES)-------------------//
//---------------------------------------------------------------------------------------//

final List<Level> levels = [
    Level( //level class is at the top of this file
      id: 1,
      title: 'Introduction to E-Waste', 
      article: '''article/ video/ infographic here ''', 
      quizzes: [
        Quiz( //quiz class is at the top of this file
          question: 'What is e-waste?',
          options: [
            'Food waste',
            'Electronic waste',
            'Paper waste',
            'Plastic waste'
          ],
          correctAnswer: 1, //**note that it starts at 0, so 1 is actually the second option
        ),
        Quiz(
          question: 'Which of these is considered e-waste?',
          options: [
            'Newspaper',
            'Broken phone',
            'Food',
            'Clothes'
          ],
          correctAnswer: 1,
        ),
      ],
      pointsToUnlock: 0, //needs to be 0 for the first one, for the following ones it needs to increase by 10 for each question in the prev level
      isUnlocked: true,
    ),
    Level(
      id: 2,
      title: 'Environmental Impact',
      article: '''article here''',
      quizzes: [
        Quiz(
          question: 'What harmful substance is found in e-waste?',
          options: [
            'Grass',
            'Salt',
            'Lead',
            'Bread'
          ],
          correctAnswer: 2, 
        ),
      ],
      pointsToUnlock: 20,
    ),
    
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//placeholder levels from 3 to 20, when you add levels above make sure to change this!!!!!!
  ...List.generate(18, (index) => Level( //18 is the num of placeholders to make so you can change this num
    id: index + 3, //change the 3 to whatever lvl the placeholders need to start at now
    title: 'Level ${index + 3}', //same here
    article: 'placeholder article for level ${index + 3}', //same here, change the 3
    quizzes: [
      Quiz(
        question: 'placeholder question 1',
        options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
        correctAnswer: 0,
      ),
      Quiz(
        question: 'placeholder question 2',
        options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
        correctAnswer: 0,
      ),
    ],
    //change the 2 to the number of lvls that are NOT placeholders
    pointsToUnlock: (index + 2) * 20, // Increases by 20 points per level
  )),
];