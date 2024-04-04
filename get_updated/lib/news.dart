import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'more.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> newsArticles = [];
  List<dynamic> filteredArticles = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNewsArticles();
  }

  Future<void> fetchNewsArticles() async {
    final apiKey = 'cf6a8b60ac2f411db3f2a0314537d249';
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse('$apiUrl'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('articles')) {
        final List<dynamic> articles = data['articles'];
        if (articles != null) {
          setState(() {
            newsArticles = articles;
            filteredArticles = articles; // Initialize filteredArticles
          });
        } else {
          throw Exception('Invalid API response: "articles" is null');
        }
      } else {
        throw Exception('Invalid API response: Missing "articles" key');
      }
    } else {
      throw Exception('Failed to load news articles');
    }
  }

  void filterArticles(String query) {
    setState(() {
      filteredArticles = newsArticles
          .where((article) =>
          article['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Get UPDATED',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterArticles,
              decoration: InputDecoration(
                labelText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final newsArticle = filteredArticles[index];
                String description = newsArticle['description'] ?? '';
                return ListTile(
                  title: Text(
                    filteredArticles[index]['title'],
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          final route = MaterialPageRoute(
                              builder: (context) => More(index: index));
                          Navigator.push(context, route);
                        },
                        child: Text(
                          'Read more',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
