//import 'package:fitplano/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/models/user.dart';
import 'package:manipal_app/resources/auth_methods.dart';
import 'package:manipal_app/resources/user_provider.dart';
import 'package:manipal_app/screens/auth_screens/login.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          GestureDetector(
            onTap: ()async{
              await AuthMethods().signOut;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
            child: Icon(Icons.logout)),
        ],
      ),
      //drawer: AppDrawer(currentRoute: '/user_profile',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(user!.photoUrl),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 150,
                      child: Icon(Icons.add_a_photo, size: 30, color: Colors.blue,)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            userProfDisplay(context, 'Name', '${user!.fullname}'),
            SizedBox(height: 10,),
            userProfDisplay(context, 'Email', '${user!.email}'),
            SizedBox(height: 10,),
            userProfDisplay(context, 'Username', '${user!.username}'),
            SizedBox(height: 10,),
            userProfDisplay(context, 'Contact No.', '${user!.contactnumber}'),
            SizedBox(height: 10,),
            
            // userProfDisplay(context, 'Gender', 'Female'),
            // SizedBox(height: 10,),
            // userProfDisplay(context, 'City', 'Mumbai'),
            // SizedBox(height: 30,),
            GestureDetector(
                      onTap: (){},
                      child: circularGradientContainer("Edit Profile", context))
        
          ],),
        ),
      ),
    );
  }
}

Widget userProfDisplay(BuildContext context, String label, String value){
  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                        SizedBox(height: 5,),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
                            borderRadius:BorderRadius.circular(10) 
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value,style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    );
}

Widget circularGradientContainer(String text, BuildContext context) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width * 0.4,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.darkGreen,AppColors.mediumGreen]),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Color.fromARGB(255, 255, 255, 255))),
    child: Text(
      text,
      style: TextStyle(color: Colors.black),
    ),
  );
}