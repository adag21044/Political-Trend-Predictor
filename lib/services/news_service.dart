import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

abstract class INewsService {
  Future<List<Article>> fetchArticles();
}

class NewsService implements INewsService {
  final String _apiUrl = "https://newsapi.org/v2/everything";
  final String _apiKey = "85ca09161381448c8dcdb34fa7e2430e"; // API anahtarınızı buraya ekleyin

  @override
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(
      Uri.parse("$_apiUrl?q=politics&language=en&apiKey=$_apiKey"),
    );

    print("NewsAPI Response Status: ${response.statusCode}");
    print("NewsAPI Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['articles'];
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }

}
