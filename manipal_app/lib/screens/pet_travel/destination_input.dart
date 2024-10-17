// import 'package:flutter/material.dart';

// class DestinationInput extends StatefulWidget {
//   final Function(String) onAddDestination;

//   const DestinationInput({Key? key, required this.onAddDestination})
//       : super(key: key);

//   @override
//   _DestinationInputState createState() => _DestinationInputState();
// }

// class _DestinationInputState extends State<DestinationInput> {
//   final TextEditingController _controller = TextEditingController();
//   final List<String> _allCities = [
//     'New Delhi',
//     'Mumbai',
//     'Bangalore',
//     'Chennai',
//     'Kolkata',
//     'Ahmedabad',
//     'Hyderabad',
//     'Pune',
//     'Jaipur',
//     'Surat',
//     'Lucknow',
//     'Kanpur',
//     'Nagpur',
//     'Indore',
//     'Thane',
//     'Bhopal',
//     'Visakhapatnam',
//     'Pimpri-Chinchwad',
//     'Patna',
//     'Vadodara',
//     'Ghaziabad',
//     'Ludhiana',
//     'Agra',
//     'Nashik',
//     'Faridabad',
//     'Meerut',
//     'Rajkot',
//     'Kalyan-Dombivli',
//     'Vasai-Virar',
//     'Varanasi',
//     'Srinagar',
//     'Aurangabad',
//     'Dhanbad',
//     'Amritsar',
//     'Navi Mumbai',
//     'Allahabad (Prayagraj)',
//     'Howrah',
//     'Ranchi',
//     'Coimbatore',
//     'Jodhpur',
//     'Gwalior',
//     'Jabalpur',
//     'Vijayawada',
//     'Madurai',
//     'Raipur',
//     'Kota',
//     'Chandigarh',
//     'Guwahati',
//     'Hubli-Dharwad',
//     'Mysore',
//     'Bareilly',
//     'Moradabad',
//     'Gurgaon',
//     'Aligarh',
//     'Jalandhar',
//     'Tiruchirappalli',
//     'Bhubaneswar',
//     'Salem',
//     'Warangal',
//     'Mira-Bhayandar',
//     'Jammu',
//     'Belgaum',
//     'Mangalore',
//     'Udaipur',
//     'Tirunelveli',
//     'Guntur',
//     'Bhiwandi',
//     'Saharanpur',
//     'Gorakhpur',
//     'Bikaner',
//     'Amravati',
//     'Noida',
//     'Jamshedpur',
//     'Bhilai',
//     'Cuttack',
//     'Firozabad',
//     'Kochi',
//     'Bhavnagar',
//     'Dehradun',
//     'Durgapur',
//     'Asansol',
//     'Nanded',
//     'Kolhapur',
//     'Ajmer',
//     'Gulbarga',
//     'Jamnagar',
//     'Ujjain',
//     'Loni',
//     'Siliguri',
//     'Jhansi',
//     'Ulhasnagar',
//     'Nellore',
//     'Jammu',
//     'Sangli',
//     'Belgaum',
//     'Mangalore',
//     'Tirupati',
//     'Thiruvananthapuram',
//     'Pondicherry',
//     'Shimla',
//     'Panaji',
//     'Imphal',
//     'Aizawl',
//     'Gangtok',
//     'Agartala'
//   ];
//   List<String> _filteredCities = [];
//   bool _showDropdown = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_filterCities);
//   }

//   void _filterCities() {
//     setState(() {
//       _filteredCities = _allCities
//           .where((city) =>
//               city.toLowerCase().contains(_controller.text.toLowerCase()))
//           .toList();
//       _showDropdown = _controller.text.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               labelText: 'Add Destination',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               filled: true,
//               fillColor: Color(0xFFDEF9C4),
//             ),
//           ),
//         ),
//         if (_showDropdown)
//           Container(
//             height: 200,
//             child: ListView.builder(
//               itemCount: _filteredCities.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_filteredCities[index]),
//                   onTap: () {
//                     widget.onAddDestination(_filteredCities[index]);
//                     _controller.clear();
//                     setState(() {
//                       _showDropdown = false;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class DestinationList extends StatelessWidget {
//   final List<String> destinations;
//   final Function(int) onRemoveDestination;

//   const DestinationList({
//     Key? key,
//     required this.destinations,
//     required this.onRemoveDestination,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: destinations.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: Chip(
//               label: Text(destinations[index]),
//               deleteIcon: const Icon(Icons.close),
//               onDeleted: () => onRemoveDestination(index),
//               backgroundColor: Color(0xFFFFDDDD),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DestinationInput extends StatefulWidget {
  final Function(String) onAddDestination;

  const DestinationInput({Key? key, required this.onAddDestination})
      : super(key: key);

  @override
  _DestinationInputState createState() => _DestinationInputState();
}

class _DestinationInputState extends State<DestinationInput> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allCities = [
    'New Delhi',
    'Mumbai',
    'Bangalore',
    'Chennai',
    'Kolkata',
    'Ahmedabad',
    'Hyderabad',
    'Pune',
    'Jaipur',
    'Surat',
    'Lucknow',
    'Kanpur',
    'Nagpur',
    'Indore',
    'Thane',
    'Bhopal',
    'Visakhapatnam',
    'Pimpri-Chinchwad',
    'Patna',
    'Vadodara',
    'Ghaziabad',
    'Ludhiana',
    'Agra',
    'Nashik',
    'Faridabad',
    'Meerut',
    'Rajkot',
    'Kalyan-Dombivli',
    'Vasai-Virar',
    'Varanasi',
    'Srinagar',
    'Aurangabad',
    'Dhanbad',
    'Amritsar',
    'Navi Mumbai',
    'Allahabad (Prayagraj)',
    'Howrah',
    'Ranchi',
    'Coimbatore',
    'Jodhpur',
    'Gwalior',
    'Jabalpur',
    'Vijayawada',
    'Madurai',
    'Raipur',
    'Kota',
    'Chandigarh',
    'Guwahati',
    'Hubli-Dharwad',
    'Mysore',
    'Bareilly',
    'Moradabad',
    'Gurgaon',
    'Aligarh',
    'Jalandhar',
    'Tiruchirappalli',
    'Bhubaneswar',
    'Salem',
    'Warangal',
    'Mira-Bhayandar',
    'Jammu',
    'Belgaum',
    'Mangalore',
    'Udaipur',
    'Tirunelveli',
    'Guntur',
    'Bhiwandi',
    'Saharanpur',
    'Gorakhpur',
    'Bikaner',
    'Amravati',
    'Noida',
    'Jamshedpur',
    'Bhilai',
    'Cuttack',
    'Firozabad',
    'Kochi',
    'Bhavnagar',
    'Dehradun',
    'Durgapur',
    'Asansol',
    'Nanded',
    'Kolhapur',
    'Ajmer',
    'Gulbarga',
    'Jamnagar',
    'Ujjain',
    'Loni',
    'Siliguri',
    'Jhansi',
    'Ulhasnagar',
    'Nellore',
    'Jammu',
    'Sangli',
    'Belgaum',
    'Mangalore',
    'Tirupati',
    'Thiruvananthapuram',
    'Pondicherry',
    'Shimla',
    'Panaji',
    'Imphal',
    'Aizawl',
    'Gangtok',
    'Agartala'
  ];
  List<String> _filteredCities = [];
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterCities);
  }

  void _filterCities() {
    setState(() {
      _filteredCities = _allCities
          .where((city) =>
              city.toLowerCase().contains(_controller.text.toLowerCase()))
          .toList();
      _showDropdown = _controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Add Destination',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Color.fromARGB(120, 250, 223, 255),
            ),
          ),
        ),
        if (_showDropdown)
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: _filteredCities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredCities[index]),
                  onTap: () {
                    widget.onAddDestination(_filteredCities[index]);
                    _controller.clear();
                    setState(() {
                      _showDropdown = false;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DestinationList extends StatelessWidget {
  final List<String> destinations;
  final Function(int) onRemoveDestination;

  const DestinationList({
    Key? key,
    required this.destinations,
    required this.onRemoveDestination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Chip(
              label: Text(destinations[index]),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => onRemoveDestination(index),
              backgroundColor: Color(0xFFFFDDDD),
            ),
          );
        },
      ),
    );
  }
}