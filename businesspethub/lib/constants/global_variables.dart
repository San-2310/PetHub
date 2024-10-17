import 'package:flutter/material.dart';

String uri = 'http://<yourip>:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color(0xFFDEF9C4), // Light green
      Color(0xFF4CAF50), // Darker green
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color(0xFFFFB1C4); // Soft pink
  static const backgroundColor = Color(0xFFFFF6F6); // Very light off-white
  static const Color greyBackgroundCOlor = Color(0xFFD9D9D9); // Light grey
  static var selectedNavBarColor = Color(0xFF4CAF50); // Green for selected navbar item
  static const unselectedNavBarColor = Color(0xFF9F9494); // Greyish brown for unselected

  // STATIC IMAGES
  static const List<String> carouselImages = [
    // Zoomed and cropped image
    'https://www.petzzing.com/cdn/shop/files/petzzing_banner_01_ce1ca02b-0687-473f-b02d-3809ca1150b0_1512x.jpg?v=1692259179'
  ];

  // CATEGORY IMAGES
  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Trackers',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Pet Spa',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Playhouses',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Puzzle',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Grooming',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}
