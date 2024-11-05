import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(ElectionPredictorApp());

class ElectionPredictorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ElectionPredictor(),
    );
  }
}

class ElectionPredictor extends StatefulWidget {
  @override
  _ElectionPredictorState createState() => _ElectionPredictorState();
}

class _ElectionPredictorState extends State<ElectionPredictor> {
  final TextEditingController pollScoreController = TextEditingController();
  final TextEditingController numericGradeController = TextEditingController();
  final TextEditingController sampleSizeController = TextEditingController();
  final TextEditingController demController = TextEditingController();
  final TextEditingController repController = TextEditingController();
  final TextEditingController indController = TextEditingController();

  String prediction = "";

  Future<void> getPrediction() async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/predict'), // Update to your deployed URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'data': [
          double.parse(pollScoreController.text),
          double.parse(numericGradeController.text),
          double.parse(sampleSizeController.text),
          double.parse(demController.text),
          double.parse(repController.text),
          double.parse(indController.text),
        ]
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        prediction = jsonDecode(response.body)['prediction'];
      });
    } else {
      throw Exception('Failed to load prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Election Predictor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField(pollScoreController, 'Poll Score'),
            buildTextField(numericGradeController, 'Numeric Grade'),
            buildTextField(sampleSizeController, 'Sample Size'),
            buildTextField(demController, 'Democratic Support (%)'),
            buildTextField(repController, 'Republican Support (%)'),
            buildTextField(indController, 'Independent Support (%)'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getPrediction,
              child: Text('Predict'),
            ),
            SizedBox(height: 20),
            Text(
              'Prediction: $prediction',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
