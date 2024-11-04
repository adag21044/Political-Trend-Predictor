import 'package:flutter/material.dart';
import '../models/article.dart';

class TrendPrediction extends StatelessWidget {
  final List<Article> articles;

  const TrendPrediction({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    int positiveCount = articles.where((article) => article.sentiment == "Positive").length;
    int negativeCount = articles.where((article) => article.sentiment == "Negative").length;
    int neutralCount = articles.where((article) => article.sentiment == "Neutral").length;

    String prediction;
    if (positiveCount > negativeCount) {
      prediction = "Gelecekte politik eğilim pozitif yönde ilerleyebilir.";
    } else if (negativeCount > positiveCount) {
      prediction = "Gelecekte politik eğilim negatif yönde ilerleyebilir.";
    } else {
      prediction = "Politik eğilimde nötr bir durum bekleniyor.";
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Eğilim Tahmini",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(prediction),
          Text("Pozitif: $positiveCount, Negatif: $negativeCount, Nötr: $neutralCount"),
        ],
      ),
    );
  }
}
