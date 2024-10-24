import 'package:flutter/material.dart';
import 'dart:math';
import 'articles.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  

  late List<NewsArticle> _displayedArticles;

  @override
  void initState() {
    super.initState();
    _displayedArticles = allArticles.take(3).toList(); 
    _updateDisplayedArticles();
  }

  void _updateDisplayedArticles() {
    Future.delayed(const Duration(milliseconds: 400 ), () { //simulate a delay to make it seem more like its actullay refreshing articles
    List<NewsArticle> availableArticles = List.from(allArticles);
    List<NewsArticle> newDisplayedArticles = [];
    
    //randomly choose 3 articles to show 
    for (int i = 0; i < 3; i++) {
      if (availableArticles.isEmpty) break;
      int randomIndex = Random().nextInt(availableArticles.length);
      newDisplayedArticles.add(availableArticles[randomIndex]);
      availableArticles.removeAt(randomIndex);
    }

    setState(() {
      _displayedArticles = newDisplayedArticles;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: ListView.builder(
        itemCount: _displayedArticles.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
                  child: Image.asset(
                    _displayedArticles[index].imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayedArticles[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        _displayedArticles[index].description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _displayedArticles[index].source,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _displayedArticles[index].date,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateDisplayedArticles();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Refreshing news...')),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}