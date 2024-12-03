import 'dart:convert';
import 'package:mynews/data/api_service.dart';
import 'package:mynews/model/headline_model.dart';

Future<Headlines> getHeadlinesUS() async {
  final res = await fetchTopHeadlinesUS();
  if (res.statusCode == 200) {
    return Headlines.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to load headlines');
  }
}

Future<Headlines> getArticlesFromQuery(String query) async {
  final res = await fetchFromquery(query);
  if (res.statusCode == 200) {
    return Headlines.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to load headlines');
  }
}
