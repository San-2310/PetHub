import 'package:flutter/material.dart';
import 'package:manipal_app/components/app_drawer.dart';
import 'package:manipal_app/components/category_cell.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/models/user.dart';
import 'package:manipal_app/resources/user_provider.dart';
//import 'package:manipal_app/screens/chat_screen/chat_screen.dart';
import 'package:manipal_app/screens/home_screen/articles/article_screen.dart';
import 'package:manipal_app/screens/home_screen/calendar.dart';
import 'package:manipal_app/screens/pet_babysitting.dart';
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
    'assets/svg/dog.png',
    'assets/svg/dog.png',
    'assets/svg/dog.png'
  ];
  int _selectedIndex = 1;

  List catArr = [
    {"image": "assets/svg/grooming.png", "name": "Grooming"},
    {"image": "assets/svg/travel.png", "name": "Travel Planning"},
    {"image": "assets/svg/babysit.png", "name": "Babysitting"},
    {"image": "assets/svg/photoshoot.png", "name": "Photoshoot"},
    {"image": "assets/Icons/service.png", "name": "Training"},
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
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    //border: Border.all(color: Colors.black)
                    color: const Color.fromRGBO(251, 233, 233, 0.85),
                    ),
                child: Padding(
                  padding: const EdgeInsets.only(top:40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
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
                                  height: 40,
                                  width: 40,
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
                                  child: Image.asset(
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
                        flex: 4,
                        child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                             // border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imageUrls[_selectedIndex],
                                  height: 100,
                                  width: 100,
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
                                    Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Text(
                                      'Breed',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.mediumGray),
                                    ),
                                    SizedBox(width: 20,),
                                    Text(
                                      '2 yrs',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.mediumGray),
                                    ),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      children: [
                                        SizedBox(
                                      width: 6,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarScreen()));
                                      },
                                        child: Image.asset(
                                            'assets/Icons/Calendar.png')),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Vet Appointment'),
                                                Text('Event'),
                                              ],
                                            ),
                                            
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.file_copy),
                                        SizedBox(width: 6,),
                                        Text('Report Summary')
                                      ],
                                    )
                                    
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
                        if(index==0)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PetTravelScreen()));
                          }
                        if(index==1)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PetTravelScreen()));
                          }
                          if(index==4){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>basicScreen()));
                          }
                          if(index==2){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PetBabySitting(userUid: user!.uid,)));
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
              }, child: Text('Article')),
              // ElevatedButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
              // }, child: Text('Chat'))
            ],
          ),
        ),
      ),
    );
  }
  
}
