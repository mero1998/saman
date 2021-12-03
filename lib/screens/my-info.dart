import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:saman_project/contorller/user_api_controller.dart';
import 'package:saman_project/getx/user_getx_controller.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';

class MyInformation extends StatelessWidget {
  const MyInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeConfig.scaleHeight(739),
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.scaleWidth(16)
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(SizeConfig.scaleHeight(37)),
                  bottomLeft: Radius.circular(SizeConfig.scaleHeight(37))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 30.0,
                  spreadRadius: -10.0,
                  offset: Offset(-1, -1), // shadow direction: bottom right
                )
              ],

            ),
            child: Stack(
              children: [
                Positioned(
                  bottom:  SizeConfig.scaleHeight(17),
                  left:  SizeConfig.scaleWidth(16),
                  right:  SizeConfig.scaleWidth(16),
                  child: Container(
                    height:SizeConfig.scaleHeight(289),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * .47,
                        // ),

                        ListOfPages(
                          title: 'معلومات حسابي',
                          image: 'icons/profile.svg',
                          onTap: (){
                            Navigator.pushNamed(context, '/account-info');
                          }
                          ,
                        ),


                        ListOfPages(title: 'تغيير كلمة المرور',
                          image: 'icons/shild.svg',
                          onTap: (){
                            Navigator.pushNamed(context, '/change-password');
                          },
                        ),
                        ListOfPages(title: 'طلباتي',
                          image: 'icons/bag.svg',
                          onTap: (){
                            Navigator.pushNamed(context, '/my-orders');
                          },
                        ),

                        // ListOfPages(title: 'بوابات الدفع',
                        //   image: 'icons/pay.svg',
                        //   onTap: (){
                        //     //MAKE PAGEVIEW
                        //     // Navigator.pushNamed(context, '/tab-bar-screen');
                        //   },
                        // ),



                        ListOfPages(title: 'الاعدادات',
                          image: 'icons/setting.svg',
                          onTap: (){
                            //MAKE Pages
                            Navigator.pushNamed(context, '/settings_screen');
                          },
                        ),


                        SizedBox(
                          height: SizeConfig.scaleHeight(5),
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.scaleWidth(80),
                          ),
                          width: double.infinity,
                          height: SizeConfig.scaleHeight(58),
                          child: ElevatedButton(
                            onPressed: () {
                              UserApiController().logout(context);
                            },
                            child: Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: SizeConfig.scaleTextFont(20)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: SizeConfig.scaleHeight(10),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ),
          Container(
            width: double.infinity,
            height: SizeConfig.scaleHeight(344),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(SizeConfig.scaleHeight(37)),
                  bottomLeft: Radius.circular(SizeConfig.scaleHeight(37))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, 0), // shadow direction: bottom right
                )
              ],
              image: DecorationImage(
                  image: AssetImage('images/gh.jpg'),
                  fit: BoxFit.cover
              ),
            ),
            clipBehavior: Clip.antiAlias,
          ),
          Positioned(
            top: SizeConfig.scaleHeight(290),
            left: SizeConfig.scaleWidth(22),
            child: Stack(
                children:[
                  CachedNetworkImage(
                    imageUrl: UserGetxController.to.user.first!.image ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      width: SizeConfig.scaleWidth(95),
                      height: SizeConfig.scaleHeight(95),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
                    ),
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Stack(
                      children: [
                        Container(
                            width: SizeConfig.scaleWidth(95),
                            height: SizeConfig.scaleHeight(95),
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: SizeConfig.scaleHeight(70),
                              color: Colors.white,
                            )),
                        Container(
                          width: SizeConfig.scaleWidth(95),
                          height: SizeConfig.scaleHeight(95),
                          decoration: BoxDecoration(
                            color:Colors.black26,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: SizeConfig.scaleHeight(15),
                    right: SizeConfig.scaleWidth(1),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,radius: SizeConfig.scaleHeight(8),
                    ),
                  )
                ]
            ),
          ),
          Positioned(
            top: SizeConfig.scaleHeight(316),
            left: SizeConfig.scaleWidth(121),
            child: Text(  UserGetxController.to.user.first!.firstName + " " +
    UserGetxController.to.user.first!.lastName,
                style: TextStyle(
                    fontSize: SizeConfig.scaleTextFont(20),
                    color: Colors.white)),
          )

        ],
      ),
    );
  }
}

class ListOfPages extends StatelessWidget {

  final String? title;
  final String? image;
  final VoidCallback? onTap;

  const ListOfPages({this.title, this.image, this.onTap}) ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: double.infinity,
        height: SizeConfig.scaleHeight(24),
        margin: EdgeInsets.only(
          top: SizeConfig.scaleHeight(21),
          right: SizeConfig.scaleWidth(17),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              SvgPicture.asset(
                '$image',
                width: SizeConfig.scaleWidth(23),
                height: SizeConfig.scaleHeight(24),
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(16),
              ),
              Text(
                '$title',
                style:
                TextStyle(color: Colors.black, fontFamily: 'Bahij',fontSize: SizeConfig.scaleTextFont(20),),
              ),
            ]

        ),
      ),
    );
  }
}

class ListTileRefactor extends StatelessWidget {

  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;

  const ListTileRefactor({this.title, this.icon, this.onTap}) ;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.scaleHeight(37.5),
      child: ListTile(
        minLeadingWidth: SizeConfig.scaleWidth(19),
        onTap: onTap,
        leading: Icon(
          icon,
          color: kPrimaryColor,
          size: SizeConfig.scaleHeight(24),
        ),
        title: Text(
          '$title',
          style:
          TextStyle(color: Colors.black, fontFamily: 'Bahij',fontSize: SizeConfig.scaleTextFont(20),),
        ),
      ),
    );
  }
}
