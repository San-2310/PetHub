import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List imageUrls = ['https://images.pexels.com/photos/2318990/pexels-photo-2318990.jpeg?cs=srgb&dl=pexels-mithulvarshan-2318990.jpg&fm=jpg',
                    'https://t3.ftcdn.net/jpg/04/81/85/46/360_F_481854656_gHGTnBscKXpFEgVTwAT4DL4NXXNhDKU9.jpg',
                    'https://img.freepik.com/premium-photo/dog-cat-are-laying-rug-with-dog-pet-care-hd-quality-image-website_1286196-1697.jpg'
  ];
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [],),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                           Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: List.generate(
                                        imageUrls.length ,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(bottom: 8),
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: _selectedIndex == index
                                                      ? const Color(0xFFD1341F)
                                                      : Colors.grey,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child:Image.network(
                                                      imageUrls[index],
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                  
                                  Expanded(
                            flex: 2,
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                      imageUrls[_selectedIndex ],
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
