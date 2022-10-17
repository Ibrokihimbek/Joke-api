class JockesList {
  String? category;
  String? type;
  String? setup;
  String? delivery;
  String? joke;
  int? id;

  JockesList({
    required this.category,
    required this.type,
    required this.setup,
    required this.delivery,
    required this.joke,
    required this.id,
  });

  factory JockesList.fromJson(Map<String, dynamic> jsonData) {
    return JockesList(
      setup: jsonData['setup'] ?? '',
      delivery: jsonData['delivery'] ?? '',
      category: jsonData['category'] ?? '',
      type: jsonData['type'] ?? '',
      joke: jsonData['joke'] ?? '',
      id: jsonData['id'] ?? 0,
    );
  }
}
