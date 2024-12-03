import 'package:http/http.dart' as http;

const API_KEY = '8bf4b325e4c5465c89d0817d5ed774a4';

Future<http.Response> fetchTopHeadlinesUS() {
  return http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$API_KEY&pageSize=40'));
}

Future<http.Response> fetchFromquery(String query) {
  return http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=$API_KEY'));
}

Future<http.Response> searchNews(String query,
    {String from = '',
    String to = '',
    String sortBy = '',
    int pageSize = 5,
    int page = 0}) {
  String url = 'https://newsapi.org/v2/everything?q=$query';
  if (from.isNotEmpty) url += '&from=$from';
  if (to.isNotEmpty) url += '&to=$to';
  if (sortBy.isNotEmpty) url += '&sortBy=$sortBy';
  if (pageSize > 0) url += '&pageSize=$pageSize';
  if (page > 0) url += '&page=$page';
  url += '&apiKey=$API_KEY';
  return http.get(Uri.parse(url));
}
