import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_reader/models/article.dart';

class NewsService with ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  // Replace with your actual API key
  final String apiKey = 'YOUR_API_KEY'; 
  final String apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=';

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl + apiKey));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        List<dynamic> articlesJson = decodedData['articles'];
        _articles = articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        // Handle error cases appropriately (e.g., show an error message)
        print('Failed to load articles. Status code: ${response.statusCode}');
        _articles = []; //Clear the articles list in case of error.
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors)
      print('Error fetching articles: $e');
      _articles = []; //Clear the articles list in case of error.
    }

    _isLoading = false;
    notifyListeners();
  }
}