// import 'package:flutter/material.dart';
// import 'package:manipal_app/components/app_drawer.dart';

// import 'package:html/dom.dart' as dom;
// import 'package:http/http.dart' as http;
// import 'package:manipal_app/components/colors.dart';
// import 'package:manipal_app/screens/pet_travel/destination_input.dart';


// class Hotel {
//   final String name;
//   final String imageUrl;
//   //final String price;
//   final String location;

//   Hotel({
//     required this.name,
//     required this.imageUrl,
//     //required this.price,
//     required this.location,
//   });
// }

// class PetTravelScreen extends StatefulWidget {
//   const PetTravelScreen({Key? key}) : super(key: key);

//   @override
//   _PetTravelScreenState createState() => _PetTravelScreenState();
// }

// class _PetTravelScreenState extends State<PetTravelScreen> {
//   List<String> destinations = [];
//   List<Hotel> hotels = [];
//   bool isLoading = false;
//   String errorMessage = '';

//   void addDestination(String destination) {
//     setState(() {
//       destinations.add(destination);
//     });
//   }

//   void removeDestination(int index) {
//     setState(() {
//       destinations.removeAt(index);
//     });
//   }

//   Future<void> searchHotels() async {
//     setState(() {
//       isLoading = true;
//       hotels.clear();
//       errorMessage = '';
//     });

//     for (String destination in destinations) {
//       try {
//         List<Hotel> destinationHotels = await fetchHotels(destination);
//         setState(() {
//           hotels.addAll(destinationHotels);
//         });
//       } catch (e) {
//         print('Error fetching hotels for $destination: $e');
//         setState(() {
//           errorMessage = 'Error fetching hotels. Please try again.';
//         });
//       }
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<List<Hotel>> fetchHotels(String destination) async {
//     final url = Uri.parse(
//         'https://www.booking.com/searchresults.en-gb.html?ss=$destination&nflt=hotelfacility%3D4');
//     final response = await http.get(url);

//     if (response.statusCode != 200) {
//       throw Exception('Failed to load page: ${response.statusCode}');
//     }

//     dom.Document html = dom.Document.html(response.body);

//     final titles = html
//         .querySelectorAll('div > h3 > a >  div')
//         .map((element) => element.innerHtml.trim())
//         .toList();

//     final urlImages = html
//         .querySelectorAll('div > a > img')
//         .map((element) => element.attributes["src"]!)
//         .toList();

//     final locations = html
//         .querySelectorAll('div > a > span > span')
//         .map((element) => element.innerHtml.trim())
//         .toList();

//     // final prices = html
//     //     .querySelectorAll('span.fcab3ed991.fbd1d3018c.e729ed5ab6')
//     //     .map((element) => element.innerHtml.trim())
//     //     .toList();

//     print('Titles found: ${titles.length}');
//     print('Images found: ${urlImages.length}');
//     print('Locations found: ${locations.length}');
//     //print('Prices found: ${prices.length}');

//     if (titles.isEmpty) {
//       throw Exception('No hotels found for $destination');
//     }

//     List<Hotel> hotels = [];
//     for (int i = 0; i < titles.length; i++) {
//       if (i < locations.length && i < urlImages.length) {
//         hotels.add(Hotel(
//           name: titles[i],
//           imageUrl: urlImages[i],
//           //price: prices[i],
//           location: locations[i],
//         ));
//       }
//     }

//     return hotels;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Pet-Friendly Travel Planner'),
//         backgroundColor: AppColors.paleGreen,
//       ),
//       body: Column(
//         children: [
//           DestinationInput(onAddDestination: addDestination),
//           DestinationList(
//             destinations: destinations,
//             onRemoveDestination: removeDestination,
//           ),
//           ElevatedButton(
            
//             onPressed: searchHotels,
//             child: const Text('Search Pet-Friendly Hotels'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromARGB(255, 152, 225, 155),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
//             ),
//           ),
//           if (errorMessage.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(errorMessage, style: TextStyle(color: Colors.red)),
//             ),
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : hotels.isEmpty
//                     ? Center(child: Text('No hotels found'))
//                     : HotelList(hotels: hotels),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HotelList extends StatelessWidget {
//   final List<Hotel> hotels;

//   const HotelList({Key? key, required this.hotels}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: hotels.length,
//       itemBuilder: (context, index) {
//         final hotel = hotels[index];
//         return Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Card(
//             elevation: 2,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       hotel.imageUrl,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           hotel.name,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           hotel.location,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             //AppColors.mediumGray,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // ListTile(

//             //   leading: Image.network(
//             //     hotel.imageUrl,
//             //     width: 100,
//             //     height: 200,
//             //     fit: BoxFit.fill,
//             //   ),
//             //   title: Text(hotel.name),
//             //   subtitle: Text(hotel.location),
//             //   // trailing: Text(
//             //   //   hotel.price,
//             //   //   style: const TextStyle(
//             //   //     fontWeight: FontWeight.bold,
//             //   //     color: Color(0xFF4CAF50),
//             //   //   ),
//             //   // ),
//             // ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:manipal_app/screens/pet_travel/destination_input.dart';


class Hotel {
  final String name;
  final String imageUrl;
  //final String price;
  final String location;

  Hotel({
    required this.name,
    required this.imageUrl,
    //required this.price,
    required this.location,
  });
}

class PetTravelScreen extends StatefulWidget {
  const PetTravelScreen({Key? key}) : super(key: key);

  @override
  _PetTravelScreenState createState() => _PetTravelScreenState();
}

class _PetTravelScreenState extends State<PetTravelScreen> {
  List<String> destinations = [];
  List<Hotel> hotels = [];
  bool isLoading = false;
  String errorMessage = '';

  void addDestination(String destination) {
    setState(() {
      destinations.add(destination);
    });
  }

  void removeDestination(int index) {
    setState(() {
      destinations.removeAt(index);
    });
  }

  Future<void> searchHotels() async {
    setState(() {
      isLoading = true;
      hotels.clear();
      errorMessage = '';
    });

    for (String destination in destinations) {
      try {
        List<Hotel> destinationHotels = await fetchHotels(destination);
        setState(() {
          hotels.addAll(destinationHotels);
        });
      } catch (e) {
        print('Error fetching hotels for $destination: $e');
        setState(() {
          errorMessage = 'Error fetching hotels. Please try again.';
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<List<Hotel>> fetchHotels(String destination) async {
    final url = Uri.parse(
        'https://www.booking.com/searchresults.en-gb.html?ss=$destination&nflt=hotelfacility%3D4');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load page: ${response.statusCode}');
    }

    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('div > h3 > a >  div')
        .map((element) => element.innerHtml.trim())
        .toList();

    final urlImages = html
        .querySelectorAll('div > a > img')
        .map((element) => element.attributes["src"]!)
        .toList();

    final locations = html
        .querySelectorAll('div > a > span > span')
        .map((element) => element.innerHtml.trim())
        .toList();

    // final prices = html
    //     .querySelectorAll('span.fcab3ed991.fbd1d3018c.e729ed5ab6')
    //     .map((element) => element.innerHtml.trim())
    //     .toList();

    print('Titles found: ${titles.length}');
    print('Images found: ${urlImages.length}');
    print('Locations found: ${locations.length}');
    //print('Prices found: ${prices.length}');

    if (titles.isEmpty) {
      throw Exception('No hotels found for $destination');
    }

    List<Hotel> hotels = [];
    for (int i = 0; i < titles.length; i++) {
      if (i < locations.length && i < urlImages.length) {
        hotels.add(Hotel(
          name: titles[i],
          imageUrl: urlImages[i],
          //price: prices[i],
          location: locations[i],
        ));
      }
    }

    return hotels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pet-Friendly Travel Planner'),
        backgroundColor: Color(0xFF9CDBA6),
      ),
      body: Column(
        children: [
          DestinationInput(onAddDestination: addDestination),
          DestinationList(
            destinations: destinations,
            onRemoveDestination: removeDestination,
          ),
          ElevatedButton(
            onPressed: searchHotels,
            child: const Text('Search Pet-Friendly Hotels'),
            style: ElevatedButton.styleFrom(
              // Setting the shape of the button to be a rounded rectangle
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              backgroundColor:
                  Colors.transparent, // This ensures the gradient is visible
            ).copyWith(
              // Adding the gradient using decoration
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation:
                  MaterialStateProperty.all(0), // Optional: remove elevation
            ),
          ).buildGradient(),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(errorMessage, style: TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : hotels.isEmpty
                    ? Center(child: Text('No hotels found'))
                    : HotelList(hotels: hotels),
          ),
        ],
      ),
    );
  }
}

class HotelList extends StatelessWidget {
  final List<Hotel> hotels;

  const HotelList({Key? key, required this.hotels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      hotel.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hotel.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            //AppColors.mediumGray,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ListTile(

            //   leading: Image.network(
            //     hotel.imageUrl,
            //     width: 100,
            //     height: 200,
            //     fit: BoxFit.fill,
            //   ),
            //   title: Text(hotel.name),
            //   subtitle: Text(hotel.location),
            //   // trailing: Text(
            //   //   hotel.price,
            //   //   style: const TextStyle(
            //   //     fontWeight: FontWeight.bold,
            //   //     color: Color(0xFF4CAF50),
            //   //   ),
            //   // ),
            // ),
          ),
        );
      },
    );
  }
}

extension GradientElevatedButton on ElevatedButton {
  Widget buildGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF9CDBA6), // Start color
            Color(0xFFDEF9C4), // End color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(19), // Rounded corners
      ),
      child: this,
    );
  }
}