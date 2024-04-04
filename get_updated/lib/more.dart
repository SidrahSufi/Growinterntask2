import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class More extends StatefulWidget {
  final int index;

  More({required this.index});

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  dynamic newsArticle;

  @override
  void initState() {
    super.initState();
    fetchNewsArticleDetails();
  }


  Future<void> fetchNewsArticleDetails() async {
    final apiKey = 'cf6a8b60ac2f411db3f2a0314537d249';
    final apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse('$apiUrl'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('articles')) {
        final List<dynamic> articles = data['articles'];
        if (articles != null) {
          setState(() {
            newsArticle = articles;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: Text('More Details'),
      ),
      body: newsArticle!= null
          ? Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10)),

          Text(newsArticle[widget.index]['title'],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              )),
          SizedBox(height: 20,),
          Text(newsArticle[widget.index]['description'],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              )),
          SizedBox(height: 40),
          Text('For more information click on the given link below:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )
          ),
          TextButton(

            child: Text(newsArticle[widget.index]['url'],
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.blueAccent
                )), onPressed: () {
            uri: Uri.parse;
          },
          )
        ],
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}