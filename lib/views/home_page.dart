import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/news_viewmodel.dart';
import '../widgets/article_card.dart';
import '../widgets/trend_chart.dart';
import '../widgets/trend_prediction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final viewModel = Provider.of<NewsViewModel>(context, listen: false);
    viewModel.fetchArticles();
  });
}

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("ABD Politik Eğilimleri"),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Güncel Politik Eğilimler",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TrendChart(
                    democratCount: viewModel.democratCount,
                    republicanCount: viewModel.republicanCount,
                  ),
                  const SizedBox(height: 24),
                  TrendPrediction(articles: viewModel.articles),
                  const SizedBox(height: 24),
                  const Text(
                    "Son Haberler",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.articles.length,
                      itemBuilder: (context, index) {
                        final article = viewModel.articles[index];
                        return ArticleCard(article: article);
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.fetchArticles,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
