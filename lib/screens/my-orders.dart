import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/getx/orders_getx_controller.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/my-small-button.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
 }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding:  EdgeInsets.only(bottom:SizeConfig.scaleHeight(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: SizeConfig.scaleWidth(16), vertical: SizeConfig.scaleHeight(10)),
                  child: Text(
                    'طلباتي',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: 'Bahij',
                      fontSize: SizeConfig.scaleTextFont(16),
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.scaleHeight(62),
                  color: kGrayColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.scaleWidth(16),
                     vertical: SizeConfig.scaleWidth(13.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text: TextSpan(
                          //create varibale to change price
                            text:'المجموع  ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.scaleTextFont(16),
                                fontFamily: 'Bahij'
                            ),
                            children: [
                              TextSpan(
                                text: '${OrdersGetxController.to.orders.length} عنصر',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: SizeConfig.scaleTextFont(16),
                                    fontFamily: 'Bahij'
                                ),
                              )
                            ]

                        ),),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(40),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
                  height: SizeConfig.scaleHeight(500),
                  child: GetX<OrdersGetxController>(
                    builder: (OrdersGetxController controller) {
                      print(controller.orders.length);
                      return ListView.builder(
                        itemCount: controller.orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            // color:Colors.red,
                            margin: EdgeInsets.symmetric(
                              vertical: SizeConfig.scaleHeight(10),
                            ),

                            // margin: EdgeInsets.symmetric(
                            //   horizontal:SizeConfig.scaleWidth(40),
                            //   vertical: SizeConfig.scaleHeight(10),
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: SizeConfig.scaleHeight(139),
                                    width: SizeConfig.scaleWidth(127),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.scaleHeight(20)),
                                      border: Border.all(color: Color(0XFFF45F5B)),
                                    image: DecorationImage(
                                      image: NetworkImage(controller.orders[index].cars.first.image_url)
                                    )
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(19),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top:SizeConfig.scaleHeight(19)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        controller.orders[index].cars.first.name,
                                        style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: SizeConfig.scaleTextFont(13),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(23),
                                      ),
                                      Text(

                                        controller.orders[index].cars.first.price!.number +
                                            controller.orders[index].cars.first.price!.type ,
                                        style: TextStyle(
                                          color: Color(0XFFF45F5B),
                                          fontFamily: 'Bahij',
                                          fontSize: SizeConfig.scaleTextFont(13),
                                        ),
                                      ),
                                      SizedBox(height: SizeConfig.scaleHeight(61),)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(31),
                                ),
                                IconButton(onPressed: (){}, icon: Icon(Icons.document_scanner_outlined,color: kPrimaryColor,size: SizeConfig.scaleHeight(25),))
                              ],
                            ),
                          );
                        },
                      );
                    },

                  ),
                ),

              ],
            ),
          )),
    );
  }
}


