//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/screens/home_screen/home_screen.dart';
import 'package:manipal_app/screens/train_pet/basic_info.dart';
import 'package:manipal_app/screens/train_pet/tricks_screen.dart';
//import 'package:paws_partners_final/views/training/tricks_screen.dart';
//import 'package:paws_partners_final/views/home_screen/home.dart';
import 'package:velocity_x/velocity_x.dart';
//import 'package:paws_partners_final/views/training/basic_info.dart';
//import '../../consts/images.dart';

class basicScreen extends StatelessWidget{
  basicScreen({super.key});

  @override
  Widget build(context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Training for Pets'),
          backgroundColor: Color.fromRGBO(255, 208, 208, 0.2),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())); // Navigate back to the previous screen
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.darkGreen,
                  AppColors.paleGreen
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.darkGreen,
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => basicScreen()),
                            );
                          },
                          child: Text('Basics',style: TextStyle(
                            color: Color.fromARGB(255, 63, 29, 56),
                          ),),
                        ),
                      ),
                      SizedBox(width: 10), // Add spacing between buttons
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => tricksScreen()),
                            );
                          },
                          child: Text('Tricks'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 220,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 185,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(225, 172, 172, 0.53),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 7.0, 10.0),
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 220,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/cardtemplate.jpg"),

                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 20.0, 20.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top left container
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                184, 190, 218, 251),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ), // Your color here
                                          child: const Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  "1",
                                                  style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "Min",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ) // Your content here
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    const Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Basic Training for Pets",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            /*Text(
                                              "\$1000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),*/
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                /*Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),*/
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Description->",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                /*Icon(
                                                  Icons.zoom_out_map,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),*/
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Description about the exercise",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 14,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "4 Reviews",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Top right heart icon
                            /*const FavoriteIcon(
                            iconColor: Colors.white,
                            iconSize: 32.0,
                          ),*/
                          ],
                        ),
                      ).onTap(() {
                        Get.to(
                              () =>
                          const basicInfo(),
                        );
                      }),
                    );
                  },
                )
              ],
            ),
          ),
        )
    );
  }

}