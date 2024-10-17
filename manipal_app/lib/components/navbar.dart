// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:manipal_app/components/colors.dart';
// import 'package:manipal_app/components/tab_button.dart';
// import 'package:manipal_app/screens/auth_screens/login.dart';
// import 'package:manipal_app/screens/community_screen/community_screen.dart';
// import 'package:manipal_app/screens/ecommerce_screen/ecommerce_screen.dart';
// import 'package:manipal_app/screens/health_screen/health_screen.dart';
// import 'package:manipal_app/screens/home_screen/home_screen.dart';
// import 'package:manipal_app/screens/user_profile_screen/user_screen.dart';

// class MainLayout extends StatefulWidget {
//   final Widget body; // Pass the page content here
//   const MainLayout({Key? key, required this.body}) : super(key: key);

//   @override
//   _MainLayoutState createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   var controller = Get.put(2.obs);

//   var navBody = [
//       HealthScreen(),
//       EcommerceScreen(),
//       HomeScreen(),
//       CommunityScreen(),
//       UserScreen()
//     ];


//   int selctTab = 2;
//   PageStorageBucket storageBucket = PageStorageBucket();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.body, // This is where the specific page content will go
//       backgroundColor: AppColors.paleGreen,
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterDocked,
//       floatingActionButton: SizedBox(
//         width: 60,
//         height: 60,
//         child: FloatingActionButton(
//           onPressed: () {
//             if (selctTab != 2) {
//               selctTab = 2;
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  HomeScreen()),
//               );
//             }
//           },
//           shape: const CircleBorder(),
//           backgroundColor: selctTab == 2 ? AppColors.darkGreen : AppColors.paleGreen,
//           child: Image.asset(
//             "assets/Icons/home.png",
//             width: 30,
//             height: 30,
//           ),
//         ),
//       ),
//       bottomNavigationBar: Obx(
//         ()=> BottomAppBar(
//           surfaceTintColor: Colors.white,
//           shadowColor: Colors.black,
//           elevation: 1,
//           notchMargin: 12,
//           height: 64,
//           shape: const CircularNotchedRectangle(),
//           child: SafeArea(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 TabButton(
//                     title: "Health",
//                     icon: "assets/Icons/Health.png",
//                     onTap: () {
//                       if (selctTab != 0) {
//                         selctTab = 0;
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => const HealthScreen()),
//                         );
//                       }
//                     },
//                     isSelected: selctTab == 0),
//                 TabButton(
//                     title: "E-Commerce",
//                     icon: "assets/Icons/Store.png",
//                     onTap: () {
//                       if (selctTab != 1) {
//                         selctTab = 1;
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => const EcommerceScreen()),
//                         );
//                       }
//                     },
//                     isSelected: selctTab == 1),
          
          
//                 const SizedBox(width: 40, height: 40,),
          
//                 TabButton(
//                     title: "Community",
//                     icon: "assets/Icons/Community.png",
//                     onTap: () {
//                       if (selctTab != 3) {
//                         selctTab = 3;
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => const CommunityScreen()),
//                         );
//                       }
//                     },
//                     isSelected: selctTab == 3),
//                 TabButton(
//                     title: "Profile",
//                     icon: "assets/Icons/profile.png",
//                     onTap: () {
//                       if (selctTab != 4) {
//                         selctTab = 4;
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => const UserScreen()),
//                         );
//                       }
//                     },
//                     isSelected: selctTab == 4),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/components/tab_button.dart';
import 'package:manipal_app/resources/user_provider.dart';
import 'package:manipal_app/screens/community_screen/feed_screen.dart';
import 'package:manipal_app/screens/health_screen/health_screen.dart';
import 'package:manipal_app/screens/ecommerce_screen/ecommerce_screen.dart';
import 'package:manipal_app/screens/home_screen/home_screen.dart';
import 'package:manipal_app/screens/community_screen/community_screen.dart';
import 'package:manipal_app/screens/user_profile_screen/user_screen.dart';
import 'package:manipal_app/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  @override
  void initState(){
    super.initState();
    addData();
  }

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen:false);
    await _userProvider.refreshUser();
  }

  final controller = Get.put(HomeController());

  final List<Widget> navBody = [
     HealthScreen(),
     EcommerceScreen(),
     HomeScreen(),
     FeedScreen(),
     UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => navBody[controller.currentNavIndex.value]),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() => SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () => controller.currentNavIndex.value = 2,
          shape: const CircleBorder(),
          backgroundColor: controller.currentNavIndex.value == 2 
              ? AppColors.paleGreen 
              : AppColors.paleGreen,
          child: Image.asset(
            "assets/Icons/home.png",
            width: 30,
            height: 30,
            color: controller.currentNavIndex.value == 2 ? Colors.black:AppColors.lightGray,
          ),
        ),
      )),
      bottomNavigationBar: Obx(() => BottomAppBar(
        color: AppColors.paleGreen,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
        notchMargin: 12,
        height: 64,
        shape: const CircularNotchedRectangle(),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                title: "Health",
                icon: "assets/Icons/Health.png",
                onTap: () => controller.currentNavIndex.value = 0,
                isSelected: controller.currentNavIndex.value == 0,
              ),
              TabButton(
                title: "E-Commerce",
                icon: "assets/Icons/Store.png",
                onTap: () => controller.currentNavIndex.value = 1,
                isSelected: controller.currentNavIndex.value == 1,
              ),
              const SizedBox(width: 40, height: 40),
              TabButton(
                title: "Community",
                icon: "assets/Icons/Community.png",
                onTap: () => controller.currentNavIndex.value = 3,
                isSelected: controller.currentNavIndex.value == 3,
              ),
              TabButton(
                title: "Profile",
                icon: "assets/Icons/profile.png",
                onTap: () => controller.currentNavIndex.value = 4,
                isSelected: controller.currentNavIndex.value == 4,
              ),
            ],
          ),
        ),
      )),
    );
  }
}