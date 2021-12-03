import 'package:flutter/material.dart';
import 'package:saman_project/getx/address_getx_controller.dart';
import 'package:saman_project/getx/user_getx_controller.dart';
import 'package:saman_project/preference/user_prefernce.dart';
import 'package:saman_project/screens/payment/revision.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/my-small-button.dart';

class AddressScreen extends StatelessWidget {
  TabController tabController;
  GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  TextEditingController _firstNameTextEditingController = TextEditingController(text: UserGetxController.to.user.value.first!.firstName);
  TextEditingController _lastNameTextEditingController = TextEditingController(text:  UserGetxController.to.user.value.first!.lastName);
  TextEditingController _emailTextEditingController = TextEditingController(text: UserGetxController.to.user.value.first!.email);
  TextEditingController _phoneTextEditingController = TextEditingController(text: UserGetxController.to.user.value.first!.mobile);
  TextEditingController _countryTextEditingController = TextEditingController(text:UserGetxController.to.user.value.first!.country!.countryname);
  TextEditingController _postalCodeTextEditingController = TextEditingController(text: UserGetxController.to.user.value.first!.countryCode);
  TextEditingController _cityTextEditingController = TextEditingController();
  TextEditingController _streetTextEditingController = TextEditingController();
  TextEditingController _areaTextEditingController = TextEditingController();

AddressScreen({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child:   Padding(
    padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
    child:   Column(
  
      children: [
  SizedBox(
    height: SizeConfig.scaleHeight(10),
  ),
        Form(
          key: _forKey,
          child: Column(
            children: [
            InfoTextField(hint: 'الاسم الاول', textInputType: TextInputType.text,textEditingController: _firstNameTextEditingController,enable: false,),
            InfoTextField(hint: 'الاسم الثاني',textInputType: TextInputType.text, textEditingController: _lastNameTextEditingController,enable: false,),
            InfoTextField(hint: 'البريد الالكتروني',textInputType: TextInputType.emailAddress,textEditingController: _emailTextEditingController,enable: false,),
            InfoTextField(hint: 'رقم الهاتف',textInputType: TextInputType.number, textEditingController: _phoneTextEditingController,enable: false,),
            InfoTextField(hint: 'الدولة',textInputType: TextInputType.text,textEditingController: _countryTextEditingController,enable: false,),
            InfoTextField(hint: 'المدينة',textInputType: TextInputType.text,textEditingController: _cityTextEditingController,),
            InfoTextField(hint: 'الشارع',textInputType: TextInputType.text,textEditingController: _streetTextEditingController,),
            InfoTextField(hint: 'المحافظة',textInputType: TextInputType.text,textEditingController: _areaTextEditingController,),
            InfoTextField(hint: 'الرمز البريدي',textInputType: TextInputType.text,textEditingController: _postalCodeTextEditingController, enable: false,),


          ],
        ),

        ),

        SizedBox(
          height: SizeConfig.scaleHeight(90),
        ),
        MySButton(
          onTap: (){
          if(_forKey.currentState!.validate()){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => Revision() ));
            AddressGetxController.to.addAddress(firstName: _firstNameTextEditingController.text, lastName: _lastNameTextEditingController.text, postalCode: _postalCodeTextEditingController.text,
                city: _cityTextEditingController.text, area: _areaTextEditingController.text, street: _streetTextEditingController.text);
            tabController.animateTo(1);
            print(tabController.index);
          }
          },
          buttonLeftMargin: SizeConfig.scaleWidth(100),
          buttonRightMargin: SizeConfig.scaleWidth(100),
          buttonTitle:'متابعة' ,
          buttonHeight: SizeConfig.scaleHeight(29),
          buttonColor: kSecondaryColor,
        ),


      ],
  
    ),
  ),
),
    );
  }
}



class InfoTextField extends StatelessWidget {
final String? hint;
final TextEditingController? textEditingController;
final TextInputType? textInputType;
final bool enable;
  const InfoTextField({this.hint, this.textEditingController, this.textInputType, this.enable = true});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى اضافة الحقول المطلوبة';
        }
        return null;
      },
      controller:textEditingController ,

      keyboardType: textInputType,
      enabled:enable ,
      decoration: InputDecoration(

        hintText: hint,

        hintStyle: TextStyle(color: kPrimaryColor,



        )

      ),

    );
  }
}
