class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String source;

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.source,
  });
}

final List<NewsArticle> allArticles = [
  //source: https://www.recyclingproductnews.com/article/42423/are-dumbphones-the-answer-to-reducing-e-waste
    NewsArticle(
      title: 'Are "dumbphones" the answer to reducing e-waste?',
      description: 'Rapid technological advances, higher consumption, planned obsolescence, and poor e-waste management are contributing to negative recycling trends',
      imageUrl: 'assets/images/article1.png',
      date: '2024-10-21',
      source: 'Recycling News',
    ),
    //source: https://www.goodnewsnetwork.org/this-robot-expertly-takes-apart-e-waste-so-their-components-can-be-reused/
    NewsArticle(
      title: 'This Robot Expertly Takes Apart E-Waste So Their Components Can Be Reused',
      description: 'A former tech hardware entrepreneur has refocused his talents on tackling the problem of electronic device waste. His startup manufactures and programs precision robots to delicately take apart products and separate still-useable components for reuse, not recycling.',
      imageUrl: 'assets/images/article2.jpg',
      date: '2024-10-17',
      source: 'Good News Network',
    ),
    //source: https://www.thecable.ng/climate-facts-global-e-waste-rising-five-times-faster-than-documented-says-unitar/
    NewsArticle(
      title: 'Global e-waste rising five times faster than documented, says UNITAR',
      description: 'The United Nations Institute for Training Research (UNITAR) says the world’s generation of electronic waste is rising five times faster than documented.',
      imageUrl: 'assets/images/article3.png',
      date: '2024-10-23',
      source: 'The Cable',
    ),
    //source: https://www.aptnnews.ca/national-news/un-says-e-waste-from-trashed-electric-devices-is-piling-up-and-recycling-isnt-keeping-pace/
        NewsArticle(
      title: 'UN says e-waste from trashed electric devices is piling up and recycling isn’t keeping pace',
      description: 'In a new report released Wednesday, the U.N.’s International Telecommunications Union and research arm UNITAR said some 62 million tons of “e-waste” was generated in 2022, enough to fill tractor-trailers that could be lined up bumper to bumper around the globe. It’s on track to reach 82 million tons by 2030.',
      imageUrl: 'assets/images/article4.png',
      date: '2024-03-20',
      source: 'APTN News',
    ),
    //source: https://canadiancoinnews.com/royal-mint-mines-gold-from-e-waste/
        NewsArticle(
      title: 'Royal Mint mines gold from e-waste',
      description: 'The Royal Mint is pioneering a sustainable approach by mining e-waste to recover precious metals.',
      imageUrl: 'assets/images/article5.png',
      date: '2024-08-29',
      source: 'Canadian Coin News',
    ),
  ];