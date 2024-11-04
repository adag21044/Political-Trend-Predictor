import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

abstract class INewsService {
  Future<List<Article>> fetchArticles();
}

class NewsService implements INewsService {
  final String _apiUrl = "https://newsapi.org/v2/everything";
  final String _apiKey = "YOUR_NEWSAPI_KEY";

  @override
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(
      Uri.parse("$_apiUrl?q=politics&language=en&apiKey=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['articles'];
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
