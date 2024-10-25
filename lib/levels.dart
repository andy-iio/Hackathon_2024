class Module {
  final String title;
  final String content;
  bool isCompleted;

  Module(
      {required this.title, required this.content, this.isCompleted = false});
}

class Level {
  final int id;
  final String title;
  final List<Module> modules;
  final List<Quiz> quizzes;
  final int pointsToUnlock;
  bool isUnlocked;
  bool isCompleted;
  int score; //0-3 stars

  Level({
    required this.id,
    required this.title,
    required this.modules,
    required this.quizzes,
    required this.pointsToUnlock,
    this.isUnlocked = true, //CHANGE TO FALSE AFTER DONE FIXING ARTICLES
    this.isCompleted = false,
    this.score = 0,
  });
  bool get allModulesCompleted => modules.every((module) => module.isCompleted);
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
    modules: [
      Module(
        title: 'What is E-Waste?',
        content:
            'Every year millions of electrical and electronic devices are discarded as products break or become obsolete and are thrown away. These discarded devices are considered e-waste and can become a threat to health and the environment if they are not disposed of and recycled appropriately.',
      ),
      Module(
        title: 'Common E-Waste Items',
        content:
            'Common e-waste items include:\n- computers\n- mobile phones\n- large household appliances\n- and medical equipment\n\nMillions of tonnes of e-waste are recycled using unsound activities, as well as being stored in homes and warehouses, dumped, and illegally exported.',
      ),
      Module(
        title: 'Environmental Impact',
        content:
            'When e-waste is recycled using unsound activities, it can release up to 1000 different chemical substances into the environment, including known neurotoxicants such as lead.',
      ),
      Module(
        title: 'Global Problem',
        content:
            'Electronic waste (e-waste) is one of the fastest growing solid waste streams in the world. Less than a quarter of e-waste produced globally in 2022 was known to be formally recycled; however, e-waste streams contain valuable and finite resources that can be reused if they are recycled appropriately.',
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
        options: ['Newspaper', 'Broken phone', 'Food', 'Clothes'],
        correctAnswer: 1,
      ),
    ],
    pointsToUnlock: 0,
    isUnlocked: true,
  ),
  Level(
    id: 2,
    //source: https://wasteaid.org/wp-content/uploads/2022/06/e-Waste_Introduction-1.pdf
    title: 'Environmental Impact',
    modules: [
      Module(
        title: 'Introduction to E-Waste',
        content:
            'E-waste refers to all items of electrical and electronic equipment (EEE) and its parts that have been discarded as waste without the intent of re-use. [STeP Initiative 2014] EEE plays an important role in improving living standards and creating income opportunities. However, growing amounts of EEE, mainly due to higher consumption and short life cycles, are generating hazardous waste streams. In 2019, just 17.4% of e-waste generated globally was collected and recycled. Africa had the lowest rate, with just 0.9% of its 2.9 Mt of e-waste recycled. Just 13 countries in Africa have a national e-waste legislation/policy or regulation in place. [Global E-waste Monitor 2020]',
      ),
      Module(
        title: 'Types of E-Waste',
        content:
            'The UN divides EEE into 54 different product-centric categories. These can be grouped into six general categories based on their waste management needs:\n• Temperature exchange equipment \n    – refrigerators, ACs, heat pumps\n• Screens and monitors \n    – televisions, computers, tablets\n• Lamps \n    – fluorescent, high intensity discharge, LED\n• Large equipment \n    – copiers, washing machines, PV panels\n• Small equipment \n    – household and business appliances\n• Small IT & telecom equipment \n    – mobile phones, routers, home printers',
      ),
      Module(
        title: 'Forms of Solar E-Waste',
        content:
            'The main components of an off-grid solar (OGS) system are solar panels, batteries, lamps, control units, cables, metal frames, and electrical appliances. Each component should be handled and recycled or disposed of in an appropriate manner.',
      ),
      Module(
        title: 'Waste-Handling Hierarchy',
        content:
            'Effective management prevents the premature appearance of solar and electronic components and products in waste streams. Prevention/avoidance includes actions to reduce the amount of waste generated by households, industry, and all levels of government, beginning with improvements in design and manufacturing to create more durable products with longer life cycles. Extension/resource recovery includes reuse, recycling, reprocessing, and energy recovery, consistent with the most efficient use of the recovered resources. Disposal includes management of all disposal options in the most environmentally responsible manner.',
      ),
      Module(
        title: 'Impact of E-Waste Management',
        content:
            'E-waste management has a critical role to play in the global shift to a circular economy and efforts to achieve the Sustainable Development Goals. Moving from a linear to a circular economy is a global priority that offers new economic opportunities while also addressing climate change and the depletion of natural resources.\n\nLinear Economy: Take-make-use-dispose. A traditional model of production and consumption in which raw materials are collected, transformed into products, used, and then discarded as waste. The energy, resources, and value put into a product are lost when a product stops functioning.\n\nCircular Economy: Take-make-use-repair-reuse-recycle-recover. A circular economy is a closed loop system in which raw materials and products are kept in use for longer and recycled. Products retain their value through repair and reuse, thus preserving limited resources and reducing or eliminating waste.',
      ),
    ],
    quizzes: [
      Quiz(
        question:
            'According to the Global E-waste Monitor 2020, what percentage of e-waste generated globally was collected and recycled in 2019?',
        options: [
          '25.6%',
          '45.8%',
          '17.4%',
          '10.2%',
        ],
        correctAnswer: 2,
      ),
      Quiz(
        question:
            'The UN categorizes electrical and electronic equipment (EEE) into 54 different product-centric categories.',
        options: ['True', 'False'],
        correctAnswer: 0,
      ),
      Quiz(
        question:
            'Which one of these is not part of the six general categories of electrical and electronic equipment (EEE) as classified by the UN?',
        options: [
          'Temperature exchange equipment',
          'Personal devices',
          'Small IT & telecom equipment',
          'Large equipment'
        ],
        correctAnswer: 1,
      ),
      Quiz(
        question:
            'Which of the following techniques is used in the waste-handling hierarchy?',
        options: [
          'Prevention / avoidance',
          'Excessive consumption',
          'Ignoring recycling programs',
          'Landfilling without sorting'
        ],
        correctAnswer: 0,
      ),
      Quiz(
        question:
            'E-waste management does not have a role in the transition from a linear economy to a circular economy.',
        options: ['True', 'False'],
        correctAnswer: 1,
      ),
    ],
    pointsToUnlock: 20,
  ),
  ...List.generate(
      18,
      (index) => Level(
            id: index + 3,
            title: 'Level ${index + 3}',
            modules: [
              Module(
                title: 'Introduction',
                content:
                    'Electronic waste, also known as e-waste, is any electronic product, or product containing electronic components, that has reached the end of its usable life cycle. Unbeknownst to many consumers, electronics actually contain toxic substances - therefore they must be handled with care when no longer wanted or needed. If a product is outdated, consumers can donate it to someone who might still find it valuable. Many retailers also offer trade-in programs or incentives for people looking to upgrade electronics that require the surrender of an older model; the retailers are able to reuse or repurpose the older models. However, if a product is totally unusable or broken, instead of just being thrown in the garbage, it must be thrown away by a certified e-waste hauler or recycler, or taken to a designated drop-off at a government building, school, or organization as e-waste can potentially cause harm to humans, animals, and the global environment if disposed of improperly.',
              ),
              Module(
                title: 'The Negative Effects on Air',
                content:
                    'Contamination in the air occurs when e-waste is informally disposed by dismantling, shredding, or melting the materials, releasing dust particles or toxins, such as dioxins, into the environment that cause air pollution and damage respiratory health. E-waste of little value is often burned, but burning also serves as a way to get valuable metal from electronics, like copper. Chronic diseases and cancers are at a higher risk to occur when burning e-waste because it also releases fine particles, which can travel thousands of miles, creating numerous negative health risks to humans and animals. Higher value materials, such as gold and silver, are often removed from highly integrated electronics by using acids, desoldering, and other chemicals, which also release fumes in areas where recycling is not regulated properly.',
              ),
              Module(
                title: 'The Negative Effects on Soil',
                content:
                    'When improper disposal of e-waste in regular landfills or in places where it is dumped illegally, both heavy metals and flame retardants can seep directly from the e-waste into the soil, causing contamination of underlying groundwater or contamination of crops that may be planted nearby or in the area in the future. When the soil is contaminated by heavy metals, the crops become vulnerable to absorbing these toxins, which can cause many illnesses and doesn’t allow the farmland to be as productive as possible.',
              ),
              Module(
                title: 'The Negative Effects on Water',
                content:
                    'After soil contamination, heavy metals from e-waste, such as mercury, lithium, lead, and barium, then leak through the earth even further to reach groundwater. When these heavy metals reach groundwater, they eventually make their way into ponds, streams, rivers, and lakes. Through these pathways, acidification and toxification are created in the water, which is unsafe for animals, plants, and communities even if they are miles away from a recycling site. Clean drinking water becomes problematic to find.',
              ),
              Module(
                title: 'The Negative Effects on Humans',
                content:
                    'As mentioned, electronic waste contains toxic components that are dangerous to human health, such as mercury, lead, cadmium, polybrominated flame retardants, barium, and lithium. The negative health effects of these toxins on humans include brain, heart, liver, kidney, and skeletal system damage. It can also considerably affect the nervous and reproductive systems of the human body, leading to disease and birth defects. Improper disposal of e-waste is unbelievably dangerous to the global environment, which is why it is so important to spread awareness of this growing problem and the threatening aftermath. To avoid these toxic effects of e-waste, it is crucial to properly e-cycle, so that items can be recycled, refurbished, resold, or reused. The growing stream of e-waste will only worsen if not educated on the correct measures of disposal.',
              ),
            ],
            quizzes: [
              Quiz(
                question:
                    'What is one of the main reasons why electronic waste (e-waste) must be handled with care when it is no longer wanted or needed?',
                options: [
                  'E-waste can often be refurbished or repaired for extended use.',
                  'E-waste contains toxic substances that can harm the environment and public health.',
                  'E-waste can break down naturally over time, causing little harm to the environment.',
                  'E-waste contains valuable materials that can be recovered through proper recycling.'
                ],
                correctAnswer: 1,
              ),
              Quiz(
                question:
                    'Higher value materials like gold and silver are often extracted from e-waste using safe and non-toxic methods.',
                options: ['True', 'False'],
                correctAnswer: 1,
              ),
              Quiz(
                question:
                    'What is one of the main environmental risks associated with the improper disposal of e-waste in landfills or illegal dumping sites?',
                options: [
                  'E-waste can release large particles into the air, which quickly re-deposit and contaminate nearby soil.',
                  'Heavy metals and chemicals from e-waste can contaminate soil, affecting groundwater and crops.',
                  'E-waste improves soil quality by adding valuable metals like copper and lead back into the ground.',
                  'Burning or shredding e-waste helps break down hazardous materials, making them safe for the environment.'
                ],
                correctAnswer: 1,
              ),
              Quiz(
                question:
                    'Once e-waste contamination causes acidification in water bodies, it primarily impacts large marine species, while freshwater organisms and plants remain largely unaffected.',
                options: ['True', 'False'],
                correctAnswer: 1,
              ),
              Quiz(
                question:
                    'Which of the following toxic components found in electronic waste can cause damage to the human brain, heart, and kidneys?',
                options: [
                  'Polybrominated flame retardants',
                  'Sodium',
                  'Mercury',
                  'Calcium'
                ],
                correctAnswer: 2,
              ),
            ],
            pointsToUnlock: (index + 2) * 20, //change to 20
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
