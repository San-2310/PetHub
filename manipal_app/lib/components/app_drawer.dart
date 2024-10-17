
import 'package:flutter/material.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/components/navbar.dart';
import 'package:manipal_app/screens/adopt_pets/adopt_pet_screen.dart';
import 'package:manipal_app/screens/home_screen/home_screen.dart';
import 'package:manipal_app/screens/insurance/insurance_screen.dart';
import 'package:manipal_app/screens/pet_nutrition.dart';
import 'package:manipal_app/screens/pet_travel/pet_travel_screen.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [
                              AppColors.darkGreen,
                              AppColors.lightGreen,
                              AppColors.mediumGreen,
                              AppColors.mediumGreen,
                              AppColors.mediumGreen,
                              //AppColors.mediumGreen,
                              AppColors.paleGreen,
                              AppColors.paleGreen,
                            ],)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pet Hub", style: TextStyle(fontSize: 50, color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildDrawerItem(context, 'Home', Icons.home, MainLayout(), '/home'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildDrawerItem(context, 'Adopt Pet', Icons.pets, PetAdoptScreen(), '/adopt_pet'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildDrawerItem(context, 'Pet Insurance', Icons.receipt, InsuranceScreen(), '/insurance'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildDrawerItem(context, 'Pet Travel', Icons.place_outlined, PetTravelScreen(), '/pet_travel'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildDrawerItem(context, 'Pet Nutrition', Icons.food_bank_outlined, PetNutritionScreen(), '/pet_nutrition'),
          ),
          
          //_buildDrawerItem(context, 'Features', Icons.star, FeaturesScreen(), '/features'),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: _buildFeaturesItem(context),
          // ),
        ],
      ),
    );
  }

 ListTile _buildDrawerItem(BuildContext context, String title, IconData icon, Widget destination, String route) {
  return ListTile(
    title: Text(title),
    leading: Icon(icon),
    selected: currentRoute == route,
    selectedTileColor: AppColors.mediumGreen,
    onTap: () {
      if (currentRoute != route) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      } else {
        Navigator.pop(context);
      }
    },
  );
}
//   Widget _buildFeaturesItem(BuildContext context) {
//     return ExpansionTile(
//       title: Text('Features'),
//       leading: Icon(Icons.star,color: Colors.black,),
//       children: [
//         _buildDrawerItem(context, 'Generate Plans',Icons.receipt,NewPlanScreen(),'/generate_plan'),
//         _buildDrawerItem(context, 'Analyze Lab Report', Icons.medical_services, AnalyzeReportScreen(),'/lab_report_screen'),
//         _buildDrawerItem(context, 'Symptom Checker', Icons.health_and_safety, SymptomChecker(),'/check_symptom'),
//       ],
//     );
//   }
 }
