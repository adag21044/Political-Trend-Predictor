import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String _apiUrl = "https://api-inference.huggingface.co/models/cardiffnlp/twitter-roberta-base-sentiment";
  final String _apiKey = "YOUR_HUGGINGFACE_API_KEY";

  Future<String> analyzeSentiment(String text) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
      },
      body: json.encode({"inputs": text}),
    );

    if (response.statusCode == 200) {
      List<dynamic> predictions = json.decode(response.body);
      String sentiment = predictions[0]['label']; // Positive, Negative, Neutral
      return sentiment;
    } else {
      throw Exception("Failed to analyze sentiment");
    }
  }
}
