import 'package:flutter/material.dart';
import '../models/article.dart';
import '../repositories/news_repository.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsRepository repository;
  List<Article> _articles = [];
  bool isLoading = false;

  List<Article> get articles => _articles;

  NewsViewModel({required this.repository});

  double get democratCount => _articles
      .where((article) => article.party == "Democrat")
      .length
      .toDouble();

  double get republicanCount => _articles
      .where((article) => article.party == "Republican")
      .length
      .toDouble();

  Future<void> fetchArticles() async {
    isLoading = true;
    notifyListeners();
    try {
      _articles = await repository.getArticlesWithSentiment();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
