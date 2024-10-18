import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manipal_app/models/articles.dart';

class ArticleService {
  static const String apiKey =
      '81b3ccc3ba2948d5882e71217430cd73'; // Sign up at newsapi.org for free
  static const String baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<Article>> fetchPetArticles() async {
    // Encoded query parameters:
    // Main topics: "pet care" OR "pet health" OR "veterinary" OR "animal care"
    // AND ("dogs" OR "cats" OR "pets" OR "pet owner" OR "veterinarian")
    // EXCLUDE: "wild animals" OR "zoo" OR "wildlife" OR "hunting" OR "pest"
    // final query = Uri.encode(
    //     '("pet care" OR "pet health" OR "veterinary" OR "animal care") '
    //     'AND (dogs OR cats OR pets OR "pet owner" OR veterinarian) '
    //     'NOT ("wild animals" OR zoo OR wildlife OR hunting OR pest)');

    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl?q=(dog OR dogs OR cat OR cats OR puppy OR kitten OR pet OR pets OR vet OR vets)'
            // ' OR ("pet care" OR "pet health" OR "veterinary care" OR "pet food" OR "pet nutrition"'
            // ' OR "pet training" OR "pet grooming" OR veterinarian OR "animal hospital")'
            ' -wild -zoo -wildlife -hunting -pest'
            '&language=en'
            '&sortBy=relevancy'
            '&pageSize=20'
            '&apiKey=$apiKey'),
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