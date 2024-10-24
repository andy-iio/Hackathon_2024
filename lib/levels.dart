import 'package:flutter/material.dart';

class Level {
  final int id;
  final String title;
  final List<Widget> article;
  final List<Quiz> quizzes;
  final int pointsToUnlock;
  bool isUnlocked;
  bool isCompleted;
  int score; //0-3 stars

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
// -------------- THE LEVEL INFO (ARTICLES/INFOGRAPHICS/VIDEOS/QUIZZES)------------------//
//---------------------------------------------------------------------------------------//

final List<Level> levels = [
  Level(
    id: 1,
    title: 'Introduction to E-Waste',
    article: [
      Text(
        'Every year millions of electrical and electronic devices are discarded as products break or become obsolete and are thrown away. These discarded devices are considered e-waste and can become a threat to health and the environment if they are not disposed of and recycled appropriately.',
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(height: 10),
      Image.asset('assets/images/article1.png'),
      SizedBox(height: 10),
      Text(
        'Common items in e-waste streams include computers, mobile phones, large household appliances, and medical equipment. Millions of tonnes of e-waste are recycled using unsound activities, as well as being stored in homes and warehouses, dumped, and illegally exported. When e-waste is recycled using unsound activities, it can release up to 1000 different chemical substances into the environment, including known neurotoxicants such as lead. Pregnant women and children are particularly vulnerable due to their pathways of exposure and developmental status. The International Labour Organization (ILO) estimates that 16.5 million children were working in the industrial sector in 2020, of which waste processing is a subsector.',
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(height: 10),
      Image.asset('assets/images/article2.jpg'),
      SizedBox(height: 10),
      Text(
        'Scope of the problem:\n'
        'Electronic waste (e-waste) is one of the fastest growing solid waste streams in the world. Less than a quarter of e-waste produced globally in 2022 was known to be formally recycled; however, e-waste streams contain valuable and finite resources that can be reused if they are recycled appropriately. E-waste has therefore become an important income stream for individuals and some communities. People living in low- and middle-income (LMICs), particularly children, face the most significant risks from e-waste due to lack of appropriate regulations and enforcement, recycling infrastructure and training. Despite international regulations targeting the control of the transport of e-waste from one country to another, its transboundary movement to LMICs continues, frequently illegally. E-waste is considered hazardous waste as it contains toxic materials and can produce toxic chemicals when recycled inappropriately. Many of these toxic materials are known or suspected to cause harm to human health, and several are included in the 10 chemicals of public health concern, including dioxins, lead, and mercury. Inferior recycling of e-waste is a threat to public health and safety.',
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(height: 10),
      Image.asset('assets/images/article3.png'),
      SizedBox(height: 10),
      Text(
        'Exposure to e-waste\n'
        'Electrical and electronic items contain many different toxic substances. Users are unlikely to have contact with these substances while the items are functional. When they become waste, these toxicants can be released into the environment if the devices are managed using environmentally-unsound practices and activities. Many unsound practices have been observed at e-waste sites including:\n'
        '- scavenging\n'
        '- dumping on land or in water bodies\n'
        '- landfilling along with regular waste\n'
        '- opening burning or heating\n'
        '- acid baths or acid leaching\n'
        '- stripping and shredding plastic coatings\n'
        '- manual disassembly of equipment.',
        style: TextStyle(fontSize: 16),
      ),
    ],
    quizzes: [
      Quiz(
        question: 'What is e-waste?',
        options: [
          'Food waste',
          'Electronic waste',
          'Paper waste',
          'Plastic waste',
        ],
        correctAnswer: 1, //1 is the second option
      ),
      Quiz(
        question: 'Which of these is considered e-waste?',
        options: [
          'Newspaper',
          'Broken phone',
          'Food',
          'Clothes',
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
    article: [
    ],
    quizzes: [
      Quiz(
        question: 'What harmful substance is found in e-waste?',
        options: [
          'Grass',
          'Salt',
          'Lead',
          'Bread',
        ],
        correctAnswer: 2,
      ),
    ],
    pointsToUnlock: 20,
  ),
  ...List.generate(18, (index) => Level(
    id: index + 3,
    title: 'Level ${index + 3}',
    article: [
      Text('Placeholder article for level ${index + 3}'),
    ],
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
    pointsToUnlock: (index + 2) * 20,
  )),
];


// class Level {
//   final int id;
//   final String title;
//   final String article;
//   final List<Quiz> quizzes;
//   final int pointsToUnlock;
//   bool isUnlocked;
//   bool isCompleted;
//   int score; // 0-3 stars

//   Level({
//     required this.id,
//     required this.title,
//     required this.article,
//     required this.quizzes,
//     required this.pointsToUnlock,
//     this.isUnlocked = false,
//     this.isCompleted = false,
//     this.score = 0,
//   });
// }

// class Quiz {
//   final String question;
//   final List<String> options;
//   final int correctAnswer;
//   bool isAnswered;
//   bool isCorrect;

//   Quiz({
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//     this.isAnswered = false,
//     this.isCorrect = false,
//   });
// }

// //---------------------------------------------------------------------------------------//
// // -------------- THE LEVEL INFO (ARTICLES/INFOGRAPHICS/VIDEOS/QUIZES)-------------------//
// //---------------------------------------------------------------------------------------//

// final List<Level> levels = [
//     Level( //level class is at the top of this file
//       id: 1,
//       title: 'Introduction to E-Waste', 
//           article: '''
// Every year millions of electrical and electronic devices are discarded as products break or become obsolete and are thrown away. These discarded devices are considered e-waste and can become a threat to health and the environment if they are not disposed of and recycled appropriately.

// Image.asset('assets/article1.png')

// Common items in e-waste streams include computers, mobile phones, large household appliances, and medical equipment. Millions of tonnes of e-waste are recycled using unsound activities, as well as being stored in homes and warehouses, dumped, and illegally exported. When e-waste is recycling using unsound activities, it can release up to 1000 different chemical substances into the environment, including known neurotoxicants such as lead. Pregnant women and children are particularly vulnerable due to their pathways of exposure and developmental status. The International Labour Organization (ILO) estimates that 16.5 million children were working in the industrial sector in 2020, of which waste processing is a subsector.

// ![Image 2](url_to_image_2)

// Scope of the problem
// Electronic waste (e-waste) is one of the fastest growing solid waste streams in the world. Less than a quarter of e-waste produced globally in 2022 was known to be formally recycled; however, e-waste streams contain valuable and finite resources that can be reused if they are recycled appropriately. E-waste has therefore become an important income stream for individuals and some communities. People living in low- and middle-income (LMICs), particularly children, face the most significant risks from e-waste due to lack of appropriate regulations and enforcement, recycling infrastructure and training. Despite international regulations targeting the control of the transport of e-waste from one country to another, its transboundary movement to LMICs continues, frequently illegally. E-waste is considered hazardous waste as it contains toxic materials and can produce toxic chemicals when recycled inappropriately. Many of these toxic materials are known or suspected to cause harm to human health, and several are included in the 10 chemicals of public health concern, including dioxins, lead, and mercury. Inferior recycling of e-waste is a threat to public health and safety.

// ![Image 3](url_to_image_3)

// Exposure to e-waste
// Electrical and electronic items contain many different toxic substances. Users are unlikely to have contact with these substances while the items are functional. When they become waste, these toxicants can be released into the environment if the devices are managed using environmentally-unsound practices and activities. Many unsound practices have been observed at e-waste sites including: 

// - scavenging
// - dumping on land or in water bodies
// - landfilling along with regular waste
// - opening burning or heating
// - acid baths or acid leaching
// - stripping and shredding plastic coatings
// - manual disassembly of equipment.
// ''', 
//       quizzes: [
//         Quiz( //quiz class is at the top of this file
//           question: 'What is e-waste?',
//           options: [
//             'Food waste',
//             'Electronic waste',
//             'Paper waste',
//             'Plastic waste'
//           ],
//           correctAnswer: 1, //**note that it starts at 0, so 1 is actually the second option
//         ),
//         Quiz(
//           question: 'Which of these is considered e-waste?',
//           options: [
//             'Newspaper',
//             'Broken phone',
//             'Food',
//             'Clothes'
//           ],
//           correctAnswer: 1,
//         ),
//       ],
//       pointsToUnlock: 0, //needs to be 0 for the first one, for the following ones it needs to increase by 10 for each question in the prev level
//       isUnlocked: true,
//     ),
//     Level(
//       id: 2,
//       title: 'Environmental Impact',
//       article: '''article here''',
//       quizzes: [
//         Quiz(
//           question: 'What harmful substance is found in e-waste?',
//           options: [
//             'Grass',
//             'Salt',
//             'Lead',
//             'Bread'
//           ],
//           correctAnswer: 2, 
//         ),
//       ],
//       pointsToUnlock: 20,
//     ),
    
// //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// //placeholder levels from 3 to 20, when you add levels above make sure to change this!!!!!!
//   ...List.generate(18, (index) => Level( //18 is the num of placeholders to make so you can change this num
//     id: index + 3, //change the 3 to whatever lvl the placeholders need to start at now
//     title: 'Level ${index + 3}', //same here
//     article: 'placeholder article for level ${index + 3}', //same here, change the 3
//     quizzes: [
//       Quiz(
//         question: 'placeholder question 1',
//         options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
//         correctAnswer: 0,
//       ),
//       Quiz(
//         question: 'placeholder question 2',
//         options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
//         correctAnswer: 0,
//       ),
//     ],
//     //change the 2 to the number of lvls that are NOT placeholders
//     pointsToUnlock: (index + 2) * 20, // Increases by 20 points per level
//   )),
// ];