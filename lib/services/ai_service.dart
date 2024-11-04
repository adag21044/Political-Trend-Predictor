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

    print("Hugging Face API Response Status: ${response.statusCode}");
    print("Hugging Face API Response Body: ${response.body}");

    if (response.statusCode == 200) {
    List<dynamic> predictions = json.decode(response.body);
    return predictions[0]['label']; // Positive, Negative, Neutral
    } else {
      throw Exception("Failed to analyze sentiment");
    }
  }
}
