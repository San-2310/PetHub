import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manipal_app/models/user.dart';


// class PetBabySitting extends StatefulWidget {
//   @override
//   _PetBabySittingState createState() => _PetBabySittingState();
// }

// class _PetBabySittingState extends State<PetBabySitting> {
//   LatLng? _currentLocation;
//   List<User> _nearbyUsers = [];
//   final String currentUserId = 'CURRENT_USER_ID'; // Replace with actual user ID

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocationAndUpdateUsers();
//   }

//   // Function to get current location and update in Firestore
//   Future<void> _getCurrentLocationAndUpdateUsers() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         return Future.error('Location services are disabled.');
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           return Future.error('Location permissions are denied.');
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         return Future.error('Location permissions are permanently denied.');
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // Update current user's location in Firestore
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUserId)
//           .update({
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//       });

//       // Get nearby users
//       await _getNearbyUsers(position.latitude, position.longitude);

//       setState(() {
//         _currentLocation = LatLng(position.latitude, position.longitude);
//       });
//     } catch (e) {
//       print('Error getting location: $e');
//     }
//   }

//   // Function to get nearby users
//   Future<void> _getNearbyUsers(double lat, double lng) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('latitude', isGreaterThan: lat - 1)
//           .where('latitude', isLessThan: lat + 1)
//           .get();

//       List<User> nearbyUsers = [];
//       for (var doc in querySnapshot.docs) {
//         User user = User.fromSnap(doc);
//         if (user.uid != currentUserId && 
//             user.longitude != null && 
//             user.longitude! >= lng - 1 && 
//             user.longitude! <= lng + 1) {
//           nearbyUsers.add(user);
//         }
//       }

//       setState(() {
//         _nearbyUsers = nearbyUsers;
//       });
//     } catch (e) {
//       print('Error getting nearby users: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Nearby Users Map'),
//         ),
//         body: _currentLocation == null
//             ? Center(child: CircularProgressIndicator())
//             : FlutterMap(
//                 options: MapOptions(
//                   // center: _currentLocation,
//                   // zoom: 13.0,
//                   initialCenter: _currentLocation!,
//                   initialZoom: 13.0
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     subdomains: ['a', 'b', 'c'],
//                     // attributionBuilder: (_) {
//                     //   return Text("©️ OpenStreetMap contributors");
//                     // },
//                   ),
//                   MarkerLayer(
//                     markers: [
//                       // Current user marker (blue)
//                       // MarkerLayers(
//                       //   width: 80.0,
//                       //   height: 80.0,
//                       //   point: _currentLocation!,
//                       //   builder: (ctx) => Icon(
//                       //     Icons.location_pin,
//                       //     color: Colors.blue,
//                       //     size: 40,
//                       //   ),
//                       // ),

//                       Marker(
//                         width: 80.0,
//                         height: 80.0,
//                         point: _currentLocation!,
//                         child:Icon(
//                           Icons.location_pin,
//                           color: Colors.blue,
//                           size: 40,
//                         ),
//                       ),


//                       // Nearby users markers (red)
//                       // ..._nearbyUsers.map((user) => Marker(
//                       //       width: 80.0,
//                       //       height: 80.0,
//                       //       point: LatLng(user.latitude!, user.longitude!),
//                       //       builder: (ctx) => Icon(
//                       //         Icons.location_pin,
//                       //         color: Colors.red,
//                       //         size: 40,
//                       //       ),
//                       //     )),
                      
//                           ..._nearbyUsers.map((user)=>Marker(
//                         width: 80.0,
//                         height: 80.0,
//                         point: LatLng(user.latitude!, user.longitude!),
//                         child:Icon(
//                           Icons.location_pin,
//                           color: Colors.red,
//                           size: 40,
//                         ),
//                       )),
//                     ],
//                   ),
//                 ],
//               ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _getCurrentLocationAndUpdateUsers,
//           child: Icon(Icons.refresh),
//           tooltip: 'Refresh Location',
//         ),
//       ),
//     );
//   }
// }







class PetBabySitting extends StatefulWidget {
  @override
  _PetBabySittingState createState() => _PetBabySittingState();
}

class _PetBabySittingState extends State<PetBabySitting> {
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Function to get the current location using Geolocator
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Current Location Tracker'),
        ),
        body: _currentLocation == null
            ? Center(child: CircularProgressIndicator())
            : FlutterMap(
                options: MapOptions(
                  // center: _currentLocation, // Center the map on current location
                  // zoom: 13.0, // Zoom level
                  initialCenter: _currentLocation!,
                  initialZoom: 13.0
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // attributionBuilder: (_) {
                    //   return Text("©️ OpenStreetMap contributors");
                    // },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _currentLocation!,
                        child:Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}