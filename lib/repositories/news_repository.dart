import '../models/article.dart';
import '../services/news_service.dart';
import '../services/ai_service.dart';

class NewsRepository {
  final INewsService newsService;
  final AIService aiService;

  NewsRepository({required this.newsService, required this.aiService});

  Future<List<Article>> getArticlesWithSentiment() async {
    final articles = await newsService.fetchArticles();
    for (var article in articles) {
      article.sentiment = await aiService.analyzeSentiment(article.title);
    }
    return articles;
  }
}
