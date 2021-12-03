import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:saman_project/getx/blog_controller_getx.dart';
import 'package:saman_project/models/blog.dart';
import 'package:saman_project/models/page.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/how-to-safe-card.dart';


class PageDetails extends StatelessWidget {
  PageSetting page;

  PageDetails({required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          page.title,
          style: TextStyle(
              fontSize: SizeConfig.scaleTextFont(16),
              fontFamily: 'Bahij',
              color: kPrimaryColor
          ),


        ),
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleHeight(20),
            color: kPrimaryColor,),onPressed: (){
          Navigator.pop(context);
        },),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
              child: Text(
                page.title,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(24),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bahij',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
              child: Text(
               page.description,
                style: TextStyle(fontSize: SizeConfig.scaleTextFont(16),fontFamily:'Bahij'),
              ),
            ),


            SizedBox(
              height: SizeConfig.scaleHeight(30),
            )

          ],
        ),
      ),

    );
  }
}

