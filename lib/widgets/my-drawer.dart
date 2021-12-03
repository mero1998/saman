import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saman_project/contorller/user_api_controller.dart';
import 'package:saman_project/getx/user_getx_controller.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/utils/size-config.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical:SizeConfig.scaleHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(10),horizontal: SizeConfig.scaleWidth(20)),

                  child: Row(
                    children: [
                      CachedNetworkImage(
                        width:SizeConfig.scaleWidth(40) ,
                        height: SizeConfig.scaleHeight(40),
                        imageUrl: UserGetxController.to.user.first!.image ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          width: 30,
                          height: 30,
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person, size: SizeConfig.scaleWidth(20), color: Colors.white,)),
                      ),
                      SizedBox(
                        width: SizeConfig.scaleWidth(20),
                      ),
                      Text(UserGetxController.to.user.first!.firstName +" "+ UserGetxController.to.user.first!.lastName,
                        style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: SizeConfig.scaleTextFont(20),


                        ),),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(10),

                ),
                Divider(color: Colors.black,),
                Column(
                  children: [
                    MenuListItems(
                      title:   'عن الشركة' ,
                      onTap: (){
                        Navigator.pushNamed(context, '/about-us');
                      },
                    ),
                    MenuListItems(
                      title:   'المدونة' ,
                      onTap: (){
                        Navigator.pushNamed(context, '/blogs');

                      },
                    ),
                   MenuListItems(
                     title: 'الاحدث عرضاً',
                     onTap: (){
                       Navigator.pushNamed(context, '/latest-show');

                     },
                   ),
                   MenuListItems(
                     title: 'خطط الاشتراكات',
                     onTap: (){
                       Navigator.pushNamed(context, '/subscription-plans');

                     },
                   ),
                   MenuListItems(
                     title: 'اتصل بنا',
                     onTap: (){
                       Navigator.pushNamed(context, '/contact-us');

                     },
                   ),
                   MenuListItems(
                     title: 'تسجيل خروج',
                     onTap: (){
                      UserApiController().logout(context);
                     },
                   ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuListItems extends StatelessWidget {

  final String? title;
  final VoidCallback? onTap;

  const MenuListItems({this.title, this.onTap}) ;



  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '$title',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Bahij',
          fontSize: SizeConfig.scaleTextFont(16),
        ),
      ),
      onTap:onTap,
    );
  }
}
