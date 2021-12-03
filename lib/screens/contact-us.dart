import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:saman_project/contorller/contact_api_message.dart';
import 'package:saman_project/utils/app_color.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
   TextEditingController _nameTextEditingController = TextEditingController();
   TextEditingController _emailTextEditingController = TextEditingController();
   TextEditingController _messageTextEditingController = TextEditingController();
   TextEditingController _mobileTextEditingController = TextEditingController();


   RxBool loading = false.obs;
  String? countryCode;

  String initialCountry = 'KW';
  PhoneNumber number = PhoneNumber(isoCode: 'KW');

  String countryName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'التواصل',
          style: TextStyle(
              fontSize: SizeConfig.scaleTextFont(16),
              fontFamily: 'Bahij',
              color: kPrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleHeight(20),
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: loading.value ? CircularProgressIndicator() : Container(
        height: SizeConfig.scaleHeight(450),
        width: SizeConfig.scaleWidth(343),
        padding: EdgeInsets.only(top: SizeConfig.scaleHeight(39),
        bottom: SizeConfig.scaleHeight(12)),
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.scaleWidth(16),
            vertical: SizeConfig.scaleHeight(30)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              SizeConfig.scaleHeight(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            InputField(
              controller: _nameTextEditingController,
              hintText: 'الاسم',
              height: SizeConfig.scaleHeight(49),
            ),
            InputField(
              controller: _emailTextEditingController,
              hintText: 'البريد الالكتروني',
              height: SizeConfig.scaleHeight(49),
              linesNumber: 2,
              keyboardType: TextInputType.emailAddress,
            ),

            Container(
              height: SizeConfig.scaleHeight(49),

              padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
              margin: EdgeInsets.only(
                bottom: SizeConfig.scaleHeight(16),
                left: SizeConfig.scaleWidth(17.5),
                right: SizeConfig.scaleWidth(17.5),
              ),

              decoration: BoxDecoration(
                color: kGrayColor,
                borderRadius: BorderRadius.circular(
                  SizeConfig.scaleHeight(24),
                ),
              ),

              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                  print(number.dialCode);
                  print(number.isoCode);
                  setState(() {
                    countryCode = number.dialCode;
                    countryName = number.isoCode!;
                  });
                },
                hintText: "رقم الموبايل",
                textStyle: TextStyle(
                  fontFamily: 'Bahij',
                  fontSize: SizeConfig.scaleTextFont(17)
                ),
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: _mobileTextEditingController,
                formatInput: false,
                keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
                inputBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade700,
                  ),
                ),
                inputDecoration: InputDecoration(
                  focusedBorder:InputBorder.none,

                  enabledBorder: InputBorder.none,
                ),
                cursorColor: kPrimaryColor,
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                  setState(() {
                    countryCode = number.dialCode;
                    countryName = number.isoCode!;
                  });
                  print(countryCode);
                  print(countryName);
                  },

              ),
            ),
            InputField(
              controller: _messageTextEditingController,
              hintText: 'اكتب الرسالة هنا',
              height: SizeConfig.scaleHeight(112),
            ),
            Spacer(),
            Container(
              height: SizeConfig.scaleHeight(44),
              width: SizeConfig.scaleWidth(159),
              margin: EdgeInsets.only(
                left: SizeConfig.scaleWidth(92),
                right: SizeConfig.scaleWidth(92),
              ),
              child: ElevatedButton(
                onPressed: () =>  performSendMessage(),
                child: Text(
                  'ارسال',
                  style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: SizeConfig.scaleTextFont(16),
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        SizeConfig.scaleHeight(12),
                      ),
                    ),
                    minimumSize: Size(SizeConfig.scaleWidth(159),
                        SizeConfig.scaleHeight(44))),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future performSendMessage() async{
    print("Click");
    if(checkData()){
      await sendMessage();
    }
  }

  bool checkData(){
    if(_nameTextEditingController.text.isNotEmpty && _emailTextEditingController.text.isNotEmpty && _messageTextEditingController.text.isNotEmpty){
      return true;
    }
    return false;
  }



  Future<bool> sendMessage() async{

    loading.value =  true;
    print(loading.value);
    bool send = await ContactApiMessage().sendContactMessage(name: _nameTextEditingController.text,
        email: _emailTextEditingController.text,
        message: _messageTextEditingController.text,
    mobile: _mobileTextEditingController.text,
      countryName: countryName,
      countryCode: countryCode!.substring(1),
    );
    if(send){
      print(loading.value);
      loading.value =  false;
      Navigator.pushNamed(context, "/bottom-nav");
    }
    return send;
  }
}

class InputField extends StatelessWidget {
  final String? hintText;
  final double? height;
  final int linesNumber;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const InputField(
      {required this.controller,
        this.hintText,
        this.height,
        this.linesNumber = 1,
        this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeConfig.scaleHeight(16),
        left: SizeConfig.scaleWidth(17.5),
        right: SizeConfig.scaleWidth(17.5),
      ),
      decoration: BoxDecoration(
        color: kGrayColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.scaleHeight(25),
        ),
      ),
      height: height,
      child: TextField(
          controller: controller,
          maxLines: 5,
          minLines: linesNumber,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              right: SizeConfig.scaleHeight(11),

              top: SizeConfig.scaleWidth(13.5),
              bottom: SizeConfig.scaleWidth(13.5),
            ),
            hintText: '$hintText',
            hintStyle: TextStyle(
                fontSize: SizeConfig.scaleTextFont(14), fontFamily: 'Bahij'),
            border: InputBorder.none,
          )),
    );
  }

}

