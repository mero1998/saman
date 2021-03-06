// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:saman_project/getx/home_controller_getx.dart';
// import 'package:saman_project/utils/constans.dart';
// import 'package:saman_project/utils/size-config.dart';
// import 'package:saman_project/widgets/my-drawer.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetX<HomeGetxController>(
//       builder: (HomeGetxController controller) {
//         return Scaffold(
//           appBar: AppBar(
//               key: _key,
//               title: Text(
//                 controller.getTitlePage(),
//                 style: TextStyle(color: Colors.black,fontSize: SizeConfig.scaleTextFont(20) ,fontFamily: 'Bahij'),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.white,
//               elevation: 0,
//               leading: Visibility(
//                 visible: controller.currentIndex.value == 0? true : false,
//
//                 child: Builder(
//                   builder: (context) => Container(
//                     height: SizeConfig.scaleHeight(20),
//                     width: SizeConfig.scaleWidth(20),
//                     margin: EdgeInsets.symmetric(
//                       horizontal: SizeConfig.scaleWidth(10),
//                       vertical: SizeConfig.scaleHeight(10),
//                     ),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: kPrimaryColor,
//                     ),
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       onPressed: () {
//                         Scaffold.of(context).openDrawer();
//                       },
//                       icon: Icon(Icons.menu,
//                           color: Colors.white, size: SizeConfig.scaleHeight(20)),
//                     ),
//                   ),
//                 ),
//               )),
//           drawer: MyDrawer(),
//           body: controller.screens[controller.currentIndex.value],
//           bottomNavigationBar: BottomNavyBar(
//             items: controller.Items,
//             backgroundColor: Color(0XFFF0F0F0),
//             iconSize: SizeConfig.scaleHeight(28),
//             containerHeight: SizeConfig.scaleHeight(60),
//             selectedIndex: controller.currentIndex.value,
//             showElevation: true, // use this to remove appBar's elevation
//             onItemSelected: (index) => setState(() {
//               controller.currentIndex.value = index;
//               // _pageController.animateToPage(index,
//               //     duration: Duration(milliseconds: 300), curve: Curves.ease);
//             }),
//             // currentIndex: controller.currentIndex.value,
//             // onTap: (int index) => controller.changeIndex(index),
//             // type: BottomNavigationBarType.shifting,
//             // selectedItemColor: kPrimaryColor,
//             // unselectedItemColor: kPrimaryColor,
//             // backgroundColor: Colors.black38,
//
//           ),
//         );
//       },
//     );
//   }
// }
