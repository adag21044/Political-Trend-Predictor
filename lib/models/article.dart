class Article {
  final String title;
  final String description;
  final String url;
  String? sentiment; // Positive, Negative, Neutral gibi değerlere sahip olacak
  String? party;     // Democrat, Republican gibi değerler alacak alan

  Article({required this.title, required this.description, required this.url, this.sentiment, this.party});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? 'No URL',
      party: json['party'] ?? 'Unknown',
    );
  }
}
