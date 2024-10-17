import 'package:businesspethub/constants/global_variables.dart';
import 'package:businesspethub/features/home/widgets/address_box.dart';
import 'package:businesspethub/features/home/widgets/carousel_image.dart';
import 'package:businesspethub/features/home/widgets/deal_of_day.dart';
import 'package:businesspethub/features/home/widgets/top_categories.dart';
import 'package:businesspethub/features/search/screens/search_screen.dart';
import 'package:businesspethub/providers/user_provider.dart';
import 'package:businesspethub/features/account/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // Default index for Home in bottom nav bar
  final AccountServices accountServices = AccountServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text('Health Screen'));
      case 1:
        return const Center(child: Text('E-Commerce Screen'));
      case 2:
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const TopCategories(),
              const SizedBox(height: 10),
              const CarouselImage(),
              const DealOfDay(),
              const SizedBox(
                  height:
                      20), // Add some spacing between DealOfDay and the QR code section
              const Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20.0), // Add vertical padding for the heading
                child: Text(
                  'Your Pet Info',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size for the heading
                    fontWeight: FontWeight.bold, // Make the heading bold
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40), // Add margin around the QR code
                child: Image.asset(
                  'assets/images/QRcode.png',
                  width: 200, // Set appropriate width
                  height: 200, // Set appropriate height
                  fit: BoxFit.contain, // Ensure it fits properly
                ),
              ),
            ],
          ),
        );
      case 3:
        return const Center(child: Text('Community Screen'));
      case 4:
        return _buildProfileScreen();
      default:
        return const Center(child: Text('Screen not found'));
    }
  }

  Widget _buildProfileScreen() {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Type: ${user.type}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => accountServices.logOut(context),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search PetHub',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: _buildScreen(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'E-Commerce',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
