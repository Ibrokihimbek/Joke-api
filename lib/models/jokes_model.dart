import 'package:news/models/jokes_list_model.dart';

class Jokes {
  List<JockesList>? jockesList;
  int? amount;

  Jokes({required this.jockesList, required this.amount});

  factory Jokes.fromjson(Map<String, dynamic> josnData) {
    return Jokes(
      amount: josnData['amount'] ?? 0,
      jockesList: (josnData['jokes'] as List)
          .map((e) => JockesList.fromJson(e))
          .toList(),
    );
  }
}
