import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saman_project/contorller/cart_controller.dart';
import 'package:saman_project/getx/cart_getx_controller.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/my-small-button.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: GetX<CartGetxController>(
      //   builder: (CartGetxController controller) {
      //     return
      //   },
      // ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'سلتي',
            style: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'Bahij',
              fontSize: SizeConfig.scaleTextFont(20),
            ),
          ),
        ),
        body: GetX<CartGetxController>(
          builder: (CartGetxController controller) {
            return controller.carts.length == 0 ?
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.shopping_cart_outlined, color: kPrimaryColor, size: SizeConfig.scaleHeight(50),),
                Text("لا يوجد منتجات بالسلة", style: TextStyle(fontSize: SizeConfig.scaleTextFont(25), fontWeight: FontWeight.bold, fontFamily: "Bahij", color:kPrimaryColor ),)
              ],),
            ) :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig.scaleHeight(55),
                  width: double.infinity,
                  color: kGrayColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(25.5),
                        vertical: SizeConfig.scaleHeight(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            //create varibale to change price
                              text: 'المجموع  ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.scaleTextFont(16),
                                  fontFamily: 'Bahij'),
                              children: [
                                TextSpan(
                                  text:
                                  controller.carts.length.toString(),
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: SizeConfig.scaleTextFont(16),
                                      fontFamily: 'Bahij'),
                                )
                              ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.removeAllFromCart();
                          },
                          child: Text(
                            'مسح العناصر',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: SizeConfig.scaleTextFont(16),
                                fontFamily: 'Bahij',
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(44),
                ),
                Container(
                    height: SizeConfig.scaleHeight(329),
                    child: ListView.builder(
                      itemCount: controller.carts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.scaleWidth(16),
                            vertical: SizeConfig.scaleHeight(10),
                          ),
                          height: SizeConfig.scaleHeight(139),
                          width: double.infinity,
                          // margin: EdgeInsets.symmetric(
                          //   horizontal:SizeConfig.scaleWidth(40),
                          //   vertical: SizeConfig.scaleHeight(10),
                          // ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.removeFromCart(
                                      carId: controller.carts[index].car!.id);
                                },
                                child: SvgPicture.asset('icons/minus.svg',width:SizeConfig.scaleWidth(20),height: SizeConfig.scaleHeight(20),),
                              ),
                              SizedBox(
                                width: SizeConfig.scaleWidth(4),
                              ),
                              Container(
                                height: SizeConfig.scaleHeight(139),
                                width: SizeConfig.scaleWidth(127),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.scaleHeight(20)),
                                    border: Border.all(color: Color(0XFFF45F5B)),
                                    image: DecorationImage(
                                      image: NetworkImage(controller.carts[index].car!.imageUrl ??
                                          ""),
                                    )),
                              ),
                              SizedBox(
                                width: SizeConfig.scaleWidth(19),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.carts[index].car!.name ??
                                        "",
                                    style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: SizeConfig.scaleTextFont(13),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(20),
                                  ),
                                  Text(
                                    "${controller.carts[index].car!.price} ريال",
                                    style: TextStyle(
                                      color: Color(0XFFF45F5B),
                                      fontFamily: 'Bahij',
                                      fontSize: SizeConfig.scaleTextFont(13),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )),
                Container(
                  height: SizeConfig.scaleHeight(62),
                  color: kGrayColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.scaleWidth(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المجموع',
                          style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(16),
                              fontFamily: 'Bahij',
                              color: kPrimaryColor),
                        ),
                        RichText(
                          text: TextSpan(
                            //create varibale to change price
                              text: controller.carts
                                  .map((element) => int.parse(element.car!.price))
                                  .toList()
                                  .reduce((value, element) => value + element)
                                  .toString(),
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: SizeConfig.scaleTextFont(16),
                                  fontFamily: 'Bahij'),
                              children: [
                                TextSpan(text: " "),
                                TextSpan(
                                  text: ' ريال',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: SizeConfig.scaleTextFont(16),
                                      fontFamily: 'Bahij'),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                MySButton(
                  onTap: () => Navigator.pushNamed(context, "/checkout_screen"),
                  buttonTitle: 'الدفع',
                  buttonColor: kPrimaryColor,
                  buttonHeight: SizeConfig.scaleHeight(35),
                  buttonLeftMargin: SizeConfig.scaleWidth(135),
                  buttonRightMargin: SizeConfig.scaleWidth(135),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(13),
                )
              ],
            );
          },

        ),
      ),
    );
  }
}
