import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/getx/page_controller_getx.dart';
import 'package:saman_project/screens/page_details.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/text_app.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextApp(text: "الاعدادات", fontSize: 20, fontWeight: FontWeight.bold, fontColor: Colors.black,),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: GetX<PageControllerGetx>(
        builder: (PageControllerGetx controller) {
       return   controller.pages.length == 0 ?  Center(child: CircularProgressIndicator()) :  ListView.builder(
              itemCount: controller.pages.length,
              itemBuilder: (context , index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PageDetails(page: controller.pages[index])));
                  },
                  child: Container(
                    height: SizeConfig.scaleHeight(50),
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.only(bottom: SizeConfig.scaleHeight(15)),
                    child: ListTile(

                      title: TextApp(text: controller.pages[index].title, fontSize: SizeConfig.scaleTextFont(20), fontWeight: FontWeight.bold, fontColor: Colors.black, textAlign: TextAlign.start,),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
