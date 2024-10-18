import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:manipal_app/screens/salon_detail.dart';

class NearbyUsersList extends StatefulWidget {
  final String userUid;

  NearbyUsersList({super.key, required this.userUid});

  @override
  _NearbyUsersListState createState() => _NearbyUsersListState();
}

class Salon {
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  final String email;
  final String phone;

  Salon({
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
    required this.email,
    required this.phone,
  });

  factory Salon.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Salon(
      id: snap.id,
      name: snapshot['name'] ?? '',
      latitude: snapshot['latitude']?.toDouble(),
      longitude: snapshot['longitude']?.toDouble(),
      email: snapshot['email'] ?? '',
      phone: snapshot['phone'] ?? '',
    );
  }
}

class _NearbyUsersListState extends State<NearbyUsersList> {
  List<Salon> _nearbySalons = [];
  double? currentLat;
  double? currentLong;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndUpdateUsers();
  }

  Future<void> _getCurrentLocationAndUpdateUsers() async {
    try {
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

      Position position = await Geolocator.getCurrentPosition(
          //desiredAccuracy: LocationAccuracy.high,
          );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userUid)
          .update({
        'latitude': position.latitude,
        'longitude': position.longitude,
      });

      setState(() {
        currentLat = position.latitude;
        currentLong = position.longitude;
      });

      await _getNearbyUsers(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _getNearbyUsers(double lat, double lng) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('salon')
          .where('latitude', isGreaterThan: lat - 0.3)
          .where('latitude', isLessThan: lat + 0.3)
          .get();

      List<Salon> nearbySalons = [];
      for (var doc in querySnapshot.docs) {
        Salon salon = Salon.fromSnap(doc);
        if (salon.longitude != null &&
            salon.longitude! >= lng - 0.3 &&
            salon.longitude! <= lng + 0.3) {
          nearbySalons.add(salon);
        }
      }

      setState(() {
        _nearbySalons = nearbySalons;
        isLoading = false;
      });
    } catch (e) {
      print('Error getting nearby salons: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String _calculateDistance(Salon salon) {
    if (currentLat == null ||
        currentLong == null ||
        salon.latitude == null ||
        salon.longitude == null) {
      return 'Distance unknown';
    }

    double latDiff = (salon.latitude! - currentLat!).abs();
    double longDiff = (salon.longitude! - currentLong!).abs();
    int minutes = (5 * (latDiff + longDiff)).round();

    return '$minutes mins away';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby Users',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(${_nearbySalons.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _nearbySalons.length,
                      itemBuilder: (context, index) {
                        final salon = _nearbySalons[index];
                        return SalonListTile(
                          salon: salon,
                          distanceText: _calculateDistance(salon),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalonListTile extends StatelessWidget {
  final Salon salon;
  final String distanceText;

  const SalonListTile({
    required this.salon,
    required this.distanceText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Color.fromRGBO(255, 236, 236, 1),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalonDetailPage(salon: salon),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Icon(Icons.cut, color: Colors.blue[800]),
          radius: 25,
        ),
        title: Text(
          salon.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              distanceText,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            Text(
              salon.phone,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}