import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:intl/intl.dart';
import 'package:saman_project/getx/blog_controller_getx.dart';
import 'package:saman_project/models/blog.dart';
import 'package:saman_project/screens/blog-details.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/how-to-safe-card.dart';

class Blogs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'المدونة',
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
      body: GetX<BlogControllerGetx>(
        builder: (BlogControllerGetx controller) {
        return Container(
           // height: SizeConfig.scaleHeight(321),
          height: MediaQuery.of(context).size.height *1,
           child:ListView.builder(
                clipBehavior: Clip.none,
                itemCount: controller.blogs.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                // scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Blog blog = controller.blogs[index];
                  return HowToSafeCard(
                    blog: blog,
                     bottomMargin: SizeConfig.scaleHeight(20),
                  );
                },
              )
        );
            },
          ),
        );

          // ListView.builder(
          //   itemCount: controller.blogs.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     Blog blog = controller.blogs[index];
          //
          //     return  BlogItem(
          //       blog: blog,
          //       onTap: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=> BlogDetails(blog: blog)));
          //     },);
          //
          //   });

  }
}

class BlogItem extends StatelessWidget {

  final VoidCallback? onTap;
  Blog blog;

   BlogItem({ required this.onTap, required this.blog}) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.scaleHeight(22)),
        width: double.infinity,
        height: SizeConfig.scaleHeight(300),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: SizeConfig.scaleHeight(205),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.scaleHeight(22),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(blog.imageUrl),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.scaleWidth(10),
                      vertical: SizeConfig.scaleHeight(8)),
                  height: SizeConfig.scaleHeight(20),
                  child: Text(
                   blog.createdAt,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: SizeConfig.scaleTextFont(15),
                        fontFamily: 'Bahij'),
                  )),
              Container(
                  height: SizeConfig.scaleHeight(26),
                  child: Text(
                   blog.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.scaleTextFont(16),
                        fontFamily: 'Bahij'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

