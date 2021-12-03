import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saman_project/contorller/user_api_controller.dart';
import 'package:saman_project/utils/app_color.dart';
import 'package:saman_project/utils/helpers.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/button_app.dart';
import 'package:saman_project/widgets/text_app.dart';
import 'package:saman_project/widgets/text_filed_app.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with Helper {

  late TextEditingController _emailTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      ),
     body : ListView(
        padding: EdgeInsetsDirectional.only(
          start: SizeConfig.scaleWidth(28),
          end: SizeConfig.scaleWidth(28),
        ),
        children: [
          TextApp(text:  "نسيان كلمة المرور", fontSize: 30, fontColor: Colors.black, fontWeight: FontWeight.w500,),
          SizedBox(height: SizeConfig.scaleHeight(17),),
          TextApp(text:  "ادخل بريدك الالكتروني هنا", height: 2 ,fontSize: 14, fontColor: AppColor.SUB_TITLE_PAGEVIEW, fontWeight: FontWeight.w500,),
          SizedBox(height: SizeConfig.scaleHeight(94),),


          TextFiledApp(hint:  "البريد الالكتروني", prefixIcon: Icons.phone_android, controller: _emailTextEditingController, textInputType: TextInputType.phone,),
          SizedBox(height: SizeConfig.scaleHeight(27),),

          ButtonApp(text: "التالي", width: double.infinity, height: 59, onPressed: () =>  performForget(),),
          SizedBox(height: SizeConfig.scaleHeight(21),),

        ],
      ),
    );
  }

  Future performForget() async{
    if(checkData()){
        await  forgetPassword();
    }
  }

  bool checkData(){

    if(_emailTextEditingController.text.isNotEmpty){
      return true;
    }
    showSnackBar(context, "ادخل البريد الالكتروني" , error:  true);

    return false;
  }

  Future forgetPassword() async{

    bool status = await UserApiController().forgetPassword(context, email: _emailTextEditingController.text);
    if(status){
      Navigator.pushNamed(context, "/login_screen");
    }
  }
}
