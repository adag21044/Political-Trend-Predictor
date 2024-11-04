import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String _apiUrl = "https://api-inference.huggingface.co/models/cardiffnlp/twitter-roberta-base-sentiment";
  final String _apiKey = "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"; // API anahtarınızı buraya ekleyin

  Future<String> analyzeSentiment(String text) async {
  final response = await http.post(
    Uri.parse(_apiUrl),
    headers: {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json",
    },
    body: json.encode({"inputs": text}),
  );

    print("Hugging Face API Response Body: ${response.body}");

    if (response.statusCode == 200) {
    List<dynamic> predictions = json.decode(response.body);

    // Check if predictions is a list of lists and contains the expected structure
    if (predictions.isNotEmpty && predictions[0] is List && predictions[0].isNotEmpty) {
      // Access the first item in the nested list
      List<dynamic> labels = predictions[0];
      
      // Get the label with the highest score
      Map<String, dynamic> highestScoreLabel = labels.reduce((curr, next) => 
          curr['score'] > next['score'] ? curr : next);

      return highestScoreLabel['label'] ?? 'Unknown';
    } else {
      throw Exception("Unexpected data format from Hugging Face API");
    }
  } else {
    throw Exception("Failed to analyze sentiment");
  }
  }
}
