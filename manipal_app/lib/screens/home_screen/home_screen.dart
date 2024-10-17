import 'package:flutter/material.dart';
import 'package:manipal_app/components/app_drawer.dart';
import 'package:manipal_app/components/category_cell.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/models/user.dart';
import 'package:manipal_app/resources/user_provider.dart';
import 'package:manipal_app/screens/home_screen/articles/article_screen.dart';
import 'package:manipal_app/screens/home_screen/calendar.dart';
import 'package:manipal_app/screens/pet_travel/pet_travel_screen.dart';
import 'package:manipal_app/screens/train_pet/basics_screen.dart';
import 'package:provider/provider.dart';
import 'package:manipal_app/screens/summarizer/summarizer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List imageUrls = [
    'https://images.pexels.com/photos/2318990/pexels-photo-2318990.jpeg?cs=srgb&dl=pexels-mithulvarshan-2318990.jpg&fm=jpg',
    'https://t3.ftcdn.net/jpg/04/81/85/46/360_F_481854656_gHGTnBscKXpFEgVTwAT4DL4NXXNhDKU9.jpg',
    'https://img.freepik.com/premium-photo/dog-cat-are-laying-rug-with-dog-pet-care-hd-quality-image-website_1286196-1697.jpg'
  ];
  int _selectedIndex = 1;

  List catArr = [
    {"image": "assets/Icons/service.png", "name": "Pet Grooming"},
    {"image": "assets/Icons/service.png", "name": "Pet Travel Planning"},
    {"image": "assets/svg/babysitting.png", "name": "Pet babysitting"},
    {"image": "assets/Icons/service.png", "name": "Photoshoot"},
    {"image": "assets/Icons/service.png", "name": "Pet Training"},
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [],
      ),
      drawer: AppDrawer(currentRoute: '/home'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black)),
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
                            imageUrls.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 90,
                                  width: 90,
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
                                  child: Image.network(
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  imageUrls[_selectedIndex],
                                  height: 150,
                                  width: 150,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Tommy',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Breed',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.mediumGray),
                                    ),
                                    Text(
                                      '2 yrs',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.mediumGray),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarScreen()));
                                      },
                                        child: Image.asset(
                                            'assets/Icons/Calendar.png'))
                                  ],
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Services",style: TextStyle(
                fontSize: 25,
                color: AppColors.mediumGray,
              ),),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: catArr.length,
                  itemBuilder: ((context, index) {
                    var cObj = catArr[index] as Map? ?? {};
                    return CategoryCell(
                      cObj: cObj,
                      onTap: () {
                        if(index==1)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PetTravelScreen()));
                          }
                          if(index==4){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>basicScreen()));
                          }
                      },
                    );
                  }),
                ),
              ),
              SizedBox(height: 20,),
              Text("Articles",style: TextStyle(
                fontSize: 25,
                color: AppColors.mediumGray,
              ),),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Report Summarizer'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SummarizerScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                 // primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticlesScreen()));
              }, child: Text('Article'))
            ],
          ),
        ),
      ),
    );
  }
  
}
