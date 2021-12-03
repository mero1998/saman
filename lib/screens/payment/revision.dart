import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/getx/address_getx_controller.dart';
import 'package:saman_project/getx/user_getx_controller.dart';
import 'package:saman_project/preference/user_prefernce.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/my-small-button.dart';

class Revision extends StatelessWidget {

  TabController tabController;

  Revision({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AddressGetxController.to.addresses.length != 0 ?  Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.scaleHeight(40),
            ),
            Container(
              height: SizeConfig.scaleHeight(425),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(
                  SizeConfig.scaleHeight(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.scaleWidth(16),
                    vertical: SizeConfig.scaleHeight(14)),

                child: GetX<AddressGetxController>(
                  builder: (controller) {

                    return ListView(
                      children: [
                        RowText(
                          infoAsked: 'الاسم الاول : ',
                          answers: UserPreferences().firstName,
                        ),
                        RowText(
                          infoAsked: ' الاسم الثاني : ',
                          answers: UserPreferences().lastName,
                        ),
                        RowText(
                          infoAsked: 'البريد الالكتروني : ',
                          answers: UserPreferences().email,
                        ),
                        RowText(
                          infoAsked: 'رقم الهاتف : ',
                          answers: UserPreferences().mobile,
                        ),
                        RowText(
                          infoAsked: 'الدولة : ',
                          answers: UserGetxController.to.user.value.first!.country!.countryname,
                        ),
                        RowText(
                          infoAsked: 'المدينة : ',
                          answers: controller.addresses.lastWhere((element) => element!.id != -1)!.city,
                        ),
                        RowText(
                          infoAsked: 'الشارع : ',
                          answers: controller.addresses.lastWhere((element) => element!.id != -1)!.street,
                        ),
                        RowText(
                          infoAsked: 'المحافظة : ',
                          answers: controller.addresses.lastWhere((element) => element!.id != -1)!.area,
                        ),
                        RowText(
                          infoAsked: 'الرمز البريدي : ',
                          answers: UserPreferences().countryCode,
                        ),
                      ],
                    );
                    // return  Container(
                    //   child: Text(controller.addresses.lastWhere((element) => element!.id != -1)!.city),
                    // );
                  },
                ),


              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: SizeConfig.scaleHeight(29),
                  margin: EdgeInsets.only(
                    left: SizeConfig.scaleWidth(10),
                    right: SizeConfig.scaleWidth(10),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      tabController.animateTo(0);

                      },
                    child: Text(
                      'رجوع',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: SizeConfig.scaleTextFont(16)),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size(SizeConfig.scaleWidth(130),
                          SizeConfig.scaleHeight(29),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SizeConfig.scaleHeight(11),

                            ),
                            side:  BorderSide(width: 1.5, color: kPrimaryColor,)

                        )),
                  ),
                ),

                SmallWidthButtons(
                  onTap: (){
                    tabController.animateTo(2);
                  },
                  buttonRightMargin:SizeConfig.scaleWidth(10) ,
                  buttonLeftMargin: SizeConfig.scaleWidth(10),
                  buttonColor: kPrimaryColor,
                  buttonTitle: 'منابعة',
                  buttonHeight: SizeConfig.scaleHeight(29),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(60),
            )
          ],
        ),
      ) : CircularProgressIndicator()

    );
  }
}

class SmallWidthButtons extends StatelessWidget {

  final Color? buttonColor;
  final String? buttonTitle;
  final double? buttonHeight;
  final double buttonLeftMargin;
  final double buttonRightMargin;
  final  VoidCallback onTap;
  final Color borderColor;


  SmallWidthButtons({this.buttonColor,
    this.buttonTitle,
    this.buttonHeight,
    required this.buttonLeftMargin,
    required this.buttonRightMargin,
    required this.onTap,
    this.borderColor = Colors.transparent,


  });

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: [
          Container(
            height: buttonHeight,
            margin: EdgeInsets.only(
              left: buttonLeftMargin,
              right: buttonRightMargin,
            ),
            child: ElevatedButton(
              onPressed: onTap,
              child: Text(
                '$buttonTitle',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.scaleTextFont(16)),
              ),
              style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  minimumSize: Size(SizeConfig.scaleWidth(130),
                    SizeConfig.scaleHeight(29),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        SizeConfig.scaleHeight(11),

                      ),
                      side:  BorderSide(width: 1.0, color: borderColor,)

                  )),
            ),
          )
        ],
      ),
    );
  }
}
class RowText extends StatelessWidget {
  final String? infoAsked;
  final String? answers;

  const RowText({this.infoAsked, this.answers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.scaleHeight(17)),
      child: RichText(
        text: TextSpan(
            text: infoAsked,
            style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(16), fontFamily: 'Cairo'),
            children: [
              TextSpan(
                text: answers,
                style: TextStyle(
                    fontSize: SizeConfig.scaleTextFont(16), fontFamily: 'Cairo'),
              )
            ]),
      ),
    );
  }
}
