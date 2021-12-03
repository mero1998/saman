import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/getx/blog_controller_getx.dart';
import 'package:saman_project/getx/page_controller_getx.dart';
import 'package:saman_project/getx/reviwes_controller_getx.dart';
import 'package:saman_project/models/blog.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/customera-comments.dart';
import 'package:saman_project/widgets/how-to-safe-card.dart';

class AboutUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('عن الشركة',
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
      body: GetX<PageControllerGetx>(
        builder: (controller) {
          return  SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageContainer(),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),

                  child: Text(
                  controller.pages.where((p0) => p0.id == 1).first.title,
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(18),
                      fontFamily: 'Bahij',
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
                  child: Text(
                    'متجر سامان',
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
                      controller.pages.where((p0) => p0.id == 1).first.description,
                    style: TextStyle(fontSize: SizeConfig.scaleTextFont(16),fontFamily:'Bahij'),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(32),
                ),

                SizedBox(
                  height: SizeConfig.scaleHeight(32),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.scaleHeight(20),
                    bottom: SizeConfig.scaleHeight(27),
                  ),
                  child: Title(
                    title: 'تقيمات عملائنا',
                  ),
                ), //customer Comment
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.scaleWidth(16)),
                  height: SizeConfig.scaleHeight(194),
                  width: double.infinity,
                  child: ListView.builder(
                      clipBehavior: Clip.none,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomersComments(reviews: ReviwesControllerGetx.to.reviews[index],);
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.scaleHeight(20),
                    bottom: SizeConfig.scaleHeight(27),
                  ),
                  child: Title(
                    title: 'أحدث التدوينات',
                  ),
                ), //stack
                Container(
                  height: SizeConfig.scaleHeight(321),
                  child: GetX<BlogControllerGetx>(
                    builder: (BlogControllerGetx controller) {
                      return ListView.builder(
                        itemCount: controller.blogs.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Blog blog = controller.blogs[index];
                          return HowToSafeCard(blog: blog,);

                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(30),
                )


              ],
            ),
          );
        },
      ),

    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeConfig.scaleHeight(15),
      ),
      width: double.infinity,
      height: SizeConfig.scaleHeight(156),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/carr.jpg'),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String? title;

  const Title({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        '$title',
        style: TextStyle(
            fontSize: SizeConfig.scaleTextFont(18), fontFamily: 'Bahij'),
      ),
    );
  }
}
