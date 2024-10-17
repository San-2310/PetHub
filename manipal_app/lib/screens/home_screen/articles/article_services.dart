import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manipal_app/models/articles.dart';

class ArticleService {
  static const String apiKey = '81b3ccc3ba2948d5882e71217430cd73'; // Sign up at newsapi.org for free
  static const String baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<Article>> fetchPetArticles() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?q=pets OR dogs OR cats OR vet OR veterinarian OR veterinary&language=en&sortBy=publishedAt&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        return articles.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}