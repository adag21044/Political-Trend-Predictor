import '../viewmodels/news_viewmodel.dart';
import '../repositories/news_repository.dart';
import '../services/ai_service.dart';
import '../services/news_service.dart';

class DependencyInjector {
  static final DependencyInjector _instance = DependencyInjector._internal();
  
  late NewsViewModel newsViewModel;

  factory DependencyInjector() {
    return _instance;
  }

  DependencyInjector._internal() {
    final newsService = NewsService();
    final aiService = AIService();
    final newsRepository = NewsRepository(newsService: newsService, aiService: aiService);
    newsViewModel = NewsViewModel(repository: newsRepository);
  }
}
