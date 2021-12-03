import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:saman_project/contorller/car_controller_api.dart';
import 'package:saman_project/getx/blog_controller_getx.dart';
import 'package:saman_project/getx/brand_controller_getx.dart';
import 'package:saman_project/getx/car_details_getx_controller.dart';
import 'package:saman_project/getx/cars_controller_getx.dart';
import 'package:saman_project/getx/cart_getx_controller.dart';
import 'package:saman_project/getx/home_controller_getx.dart';
import 'package:saman_project/getx/orders_getx_controller.dart';
import 'package:saman_project/getx/page_controller_getx.dart';
import 'package:saman_project/getx/partners_controller_getx.dart';
import 'package:saman_project/getx/reviwes_controller_getx.dart';
import 'package:saman_project/getx/serach_controller_getx.dart';
import 'package:saman_project/getx/user_getx_controller.dart';
import 'package:saman_project/getx/wishlist_getx_controller.dart';
import 'package:saman_project/models/blog.dart';
import 'package:saman_project/models/cars.dart';
import 'package:saman_project/models/colors.dart';
import 'package:saman_project/models/models.dart';
import 'package:saman_project/screens/cars_with_brand.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/widgets/consultation.dart';
import 'package:saman_project/widgets/customera-comments.dart';
import 'package:saman_project/widgets/how-to-safe-card.dart';
import 'package:saman_project/widgets/my-drawer.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/my-small-button.dart';
import 'package:saman_project/widgets/product-widgt.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RangeValues _currentRangeValues = RangeValues(40, 80);
  TextEditingController typeCar = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController carColor = TextEditingController();
  RxString isOld = "0".obs;

  // bool selectNew = true;
  // bool selectOld = false;
  // bool filter = false;
  //
  // // bool isSelected = false;
  // late Cars cars;

  // List<String> _modelsList = [
  //   "2016",
  //   "2017",
  //   "2018",
  //   "2019",
  //   "2020",
  //   "2021",
  // ];
  // List<String> _colorsList = [
  //  "Blue - أزرق",
  //  "Grey - رمادي",
  //  "Silver - فضي",
  //  "Red - أحمر",
  //  "White - أبيض",
  //  "Black - أسود",
  // ];
  String? dropdownValueModels;
  String? dropdownValueColors;
  String price = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WishlistGetxController controller = Get.put(WishlistGetxController());
     Get.put(BrandControllerGetx());
    // HomeGetxController controller = Get.put(HomeGetxController());
     Get.put(CarsGetxController());
    Get.put(BlogControllerGetx());
   Get.put(UserGetxController());
        Get.put(PartnersControllerGetx());
        Get.put(ReviwesControllerGetx());

   Get.put(CartGetxController());
    Get.put(PageControllerGetx());
    Get.put(OrdersGetxController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "المتجر",
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.scaleTextFont(20),
                fontFamily: 'Bahij'),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) => Container(
              height: SizeConfig.scaleHeight(20),
              width: SizeConfig.scaleWidth(20),
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.scaleWidth(10),
                vertical: SizeConfig.scaleHeight(10),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu,
                    color: Colors.white, size: SizeConfig.scaleHeight(20)),
              ),
            ),
          )),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.scaleHeight(336),
              child: Stack(
                children: [
                  Container(
                    height: SizeConfig.scaleHeight(285),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'images/backgro.png',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.scaleHeight(35),
                    right: SizeConfig.scaleWidth(45),
                    left: SizeConfig.scaleWidth(45),
                    child: Container(
                      // height: SizeConfig.scaleHeight(317),
                      width: SizeConfig.scaleWidth(285),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            SizeConfig.scaleHeight(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0XD9FF8D00), Color(0XD9F45F5B)],
                          )),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: SizeConfig.scaleWidth(33.5),
                          left: SizeConfig.scaleWidth(33.5),
                          top: SizeConfig.scaleHeight(19),
                          bottom: SizeConfig.scaleHeight(17),
                        ),
                        child: Container(
                              child: Column(
                                children: [
                                  MainTetField(
                                    titleText: 'نوع السيارة',
                                    textEditingController: typeCar,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(27),                                    child: GetX<SearchControllerGetx>(
                                      // init: GetxControllerCiteis(),
                                        builder : (SearchControllerGetx controller){
                                          if(controller.models.isNotEmpty){
                                            return controller.models.length != 0 ?
                                            DropdownButtonFormField<ModelsCars>(
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsetsDirectional.only(
                                                  start: 15,
                                                ),
                                                  enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(7)),
                                                  borderSide: BorderSide.none
                                                  ),
                                                fillColor: Colors.white,
                                                filled: true
                                              ),
                                              hint: Text("اختر سنة الموديل"),
                                              items: controller.models.value.map((e) => DropdownMenuItem<ModelsCars>(
                                                child: Text(e.modelYear, style:TextStyle(fontSize: SizeConfig.scaleTextFont(16),fontFamily: 'Bahij')),
                                                // value: e.nameEn,
                                                value: e,
                                              )).toList(),
                                              value: controller.models.value.elementAt(0),
                                              onChanged: (ModelsCars? models){
                                                setState(() {
                                                  dropdownValueModels = models?.modelYear;
                                                });
                                              },
                                            )
                                            : Center(child: CircularProgressIndicator());

                                          }else{
                                            return Text("");
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(27),
                                    child: GetX<SearchControllerGetx>(
                                        builder : (SearchControllerGetx controller){
                                          if(controller.colors.isNotEmpty){
                                            return controller.colors.length != 0 ?
                                            DropdownButtonFormField<ColorsCars>(
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsetsDirectional.only(
                                                    start: 15,
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(7)),
                                                      borderSide: BorderSide.none
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true
                                              ),
                                              items: controller.colors.value.map((e) => DropdownMenuItem<ColorsCars>(
                                                child: Text(e.color,style: TextStyle(fontSize: SizeConfig.scaleTextFont(16),fontFamily: 'Bahij'),),
                                                 
                                                 // value: e.nameEn,
                                                value: e,
                                              )).toList(),
                                              value: controller.colors.value.elementAt(0),
                                              onChanged: (ColorsCars? color){
                                                setState(() {
                                                  dropdownValueColors = color?.color;
                                                });
                                              },
                                            )
                                            : Center(child: CircularProgressIndicator());

                                          }else{
                                            return Text("");
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  NewAndUsedButtons(
                                    isOld: isOld.value,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(14),
                                  ),
                                  Container(
                                    height: SizeConfig.scaleHeight(26),
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Color(0XFF070908),
                                        inactiveTickMarkColor: Colors.white,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 13.0),
                                        thumbColor: Colors.white,
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 20),
                                        overlayColor: Color(0X29EB1555),
                                      ),
                                      child: RangeSlider(
                                          values: _currentRangeValues,
                                          min: 0,
                                          max: 50000,
                                          divisions: 20,
                                          labels: RangeLabels(
                                            _currentRangeValues.start
                                                .round()
                                                .toString(),
                                            _currentRangeValues.end
                                                .round()
                                                .toString(),
                                          ),
                                          onChanged: (RangeValues values) {
                                            setState(() {
                                              _currentRangeValues = values;
                                              price = _currentRangeValues.end
                                                  .round()
                                                  .toString();
                                              print(values);
                                            });
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(28.5),
                                  ),
                                  MySButton(
                                    onTap: () {
                                      setState(() {
                                        CarsGetxController.to
                                            .changeFilterState(true);
                                        CarsGetxController.to.showList();
                                        CarsGetxController.to.getFilterCar(
                                          model: dropdownValueModels ?? "",
                                          color: dropdownValueColors ?? "",
                                          isOld: isOld.value,
                                          type: typeCar.text,
                                          price_to:
                                          _currentRangeValues.end.toString(),
                                          price_from:
                                          _currentRangeValues.start.toString(),
                                        );
                                        // CarsGetxController.to.getFilterCar(model: "2015", color: "أبيض – White", isOld: "0" , type: "2015 Kia Sport age", price : "5");
                                        CarsGetxController.to.getCars();
                                        //   CarsGetxController().indexFilterCars(
                                        //       price_from: "500",
                                        //       price_to: "5000",
                                        //       color: "white",
                                        //       model: "2021",
                                        //       brand_id: "9",
                                        //       isOld: "0");
                                      });
                                    },
                                    buttonTitle: 'بحث',
                                    buttonColor: Color(0XFF231F1F),
                                    buttonHeight: SizeConfig.scaleHeight(27),
                                    buttonLeftMargin: SizeConfig.scaleWidth(59),
                                    buttonRightMargin: SizeConfig.scaleWidth(59),
                                  ),
                                ],
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(20),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(16)),
              child: Text(
                'افضل العلامات التجارية لدينا',
                style: TextStyle(
                  fontFamily: 'Bahij',
                  fontSize: SizeConfig.scaleTextFont(20),
                ),
              ),
            ),
            BestMarcas(),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleWidth(16),
                  vertical: SizeConfig.scaleHeight(26)),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        CarsGetxController.to.changeNewState(true);
                        CarsGetxController.to.showList();
                        CarsGetxController.to.getCars();
                      });
                    },
                    child: Text(
                      "جديد",
                      style: TextStyle(
                          fontSize: SizeConfig.scaleTextFont(16),
                          color: CarsGetxController.to.selectNew.value
                              ? Colors.white
                              : Colors.black,
                          fontFamily: "Bahij",
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          SizeConfig.scaleWidth(96),
                          SizeConfig.scaleHeight(47),
                        ),
                        primary: CarsGetxController.to.selectNew.value
                            ? kPrimaryColor
                            : Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.scaleHeight(5)))),
                  ),
                  SizedBox(
                    width: SizeConfig.scaleWidth(5),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        CarsGetxController.to.changeOldState(true);
                        CarsGetxController.to.showList();
                        CarsGetxController.to.getCars();
                      });
                    },
                    child: Text("مستخدم",
                        style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(16),
                            color: CarsGetxController.to.selectOld.value
                                ? Colors.white
                                : Colors.black,
                            fontFamily: "Bahij",
                            fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          SizeConfig.scaleWidth(96),
                          SizeConfig.scaleHeight(47),
                        ),
                        primary: CarsGetxController.to.selectOld.value
                            ? kPrimaryColor
                            : Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.scaleHeight(5)))),
                  )

                  // NewOldButtons(
                  //   onTap: () {
                  //     homeController.changeStateButton(true);
                  //     setState(() {
                  //       select = !select;
                  //     });
                  //   },
                  //   isNew:  homeController.newest.value,
                  //   title: Text(
                  //     'جديد',
                  //     style: TextStyle(
                  //         fontFamily: 'Bahij',
                  //         color: Colors.white,
                  //         fontSize: SizeConfig.scaleTextFont(16)),
                  //   ),
                  //   buttonColor: kPrimaryColor,
                  // ),
                  // SizedBox(
                  //   width: SizeConfig.scaleWidth(20),
                  // ),
                  // NewOldButtons(
                  //   onTap: () {
                  //     homeController.changeStateButton(false);
                  //     setState(() {
                  //       select = !select;
                  //     });
                  //   },
                  //   isNew:   homeController.newest.value,
                  //   title: Text(
                  //     'مستخدم',
                  //     style: TextStyle(
                  //         fontFamily: 'Bahij',
                  //         color: Colors.black,
                  //         fontSize: SizeConfig.scaleTextFont(16)),
                  //   ),
                  //   buttonColor: Colors.white,
                  // ),
                ],
              ),
            ),
            //product listView
            GetX<CarsGetxController>(
                builder: (CarsGetxController carsController) {
              return Visibility(
                visible: CarsControllerApi().isExeption == false,
                child: Container(
                    height: SizeConfig.scaleHeight(285),
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: carsController.getListLength(),
                        scrollDirection: Axis.horizontal,
                        controller: carsController.scroll,
                        itemBuilder: (BuildContext context, int index) {
                          // carsController.showList();
                          return carsController.showCars.length != 0 ? Container(
                              margin: EdgeInsets.only(
                                  right: SizeConfig.scaleWidth(16)),
                              child: ProductWidget(cars: carsController.showCars[index],)
                          ) : Text("لا يوجد سيارات");
                        })),
              );
            }),
            SizedBox(
              height: SizeConfig.scaleHeight(33),
            ),
            //product listView
            // Container(
            //   height: SizeConfig.scaleHeight(285),
            //   width: double.infinity,
            //   child: ListView.builder(
            //       itemCount: 5,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Container(
            //             margin:
            //             EdgeInsets.only(right: SizeConfig.scaleWidth(16)),
            //             child: ProductWidget());
            //       }),
            // ),

            Consultation(),

            Container(
                margin:
                    EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(20)),
                child: Title(
                  title: 'شركاؤنا',
                )),
            Partners(),

            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.scaleHeight(20),
                bottom: SizeConfig.scaleHeight(27),
              ),
              child: Title(
                title: 'تقيمات عملائنا',
              ),
            ),
            //customer Comment
            GetX<ReviwesControllerGetx>(
              builder: (ReviwesControllerGetx controller) {
                return Container(
                  margin: EdgeInsets.only(right: SizeConfig.scaleWidth(16)),
                  height: SizeConfig.scaleHeight(194),
                  width: double.infinity,
                  child: ListView.builder(
                      clipBehavior: Clip.none,
                      itemCount: controller.reviews.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomersComments(
                          reviews: controller.reviews[index],
                        );
                      }),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.scaleHeight(20),
                bottom: SizeConfig.scaleHeight(27),
              ),
              child: Title(
                title: 'أحدث التدوينات',
              ),
            ),

            //stack
            Container(
              height: SizeConfig.scaleHeight(321),
              child: GetX<BlogControllerGetx>(
                builder: (BlogControllerGetx controller) {
                  return ListView.builder(
                    clipBehavior: Clip.none,
                    itemCount: controller.blogs.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Blog blog = controller.blogs[index];
                      return HowToSafeCard(
                        blog: blog,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(30),
            ),
          ],
        ),
      ),
    );
  }
}

class Partners extends StatelessWidget {
  const Partners({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
      width: double.infinity,

      height: SizeConfig.scaleHeight(86),

      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.scaleHeight(21),
            ),
          ),
          Container(
            height: SizeConfig.scaleHeight(86),
            width: SizeConfig.scaleWidth(292),
            // color: Colors.greenAccent,
            child: GetX<PartnersControllerGetx>(
              builder: (PartnersControllerGetx controller) {
                return ListView.builder(
                    itemCount: controller.partners.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin:
                            EdgeInsets.only(left: SizeConfig.scaleWidth(17)),
                        height: SizeConfig.scaleHeight(86),
                        width: SizeConfig.scaleWidth(86),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(controller.partners[index].image),
                        )),
                      );
                    });
              },
            ),
          ),
          GestureDetector(
            onTap: () {},
            child:
                Icon(Icons.arrow_forward_ios, size: SizeConfig.scaleHeight(21)),
          ),
        ],
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

// class NewOldButtons extends StatelessWidget {
//   final Color? buttonColor;
//   final Text? title;
//   final VoidCallback? onTap;
//   final bool? isNew;
//
//   const NewOldButtons({this.buttonColor, this.title, this.onTap, this.isNew});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onTap,
//       child: title,
//       style: ElevatedButton.styleFrom(
//           minimumSize: Size(
//             SizeConfig.scaleWidth(96),
//             SizeConfig.scaleHeight(47),
//           ),
//           primary: isNew! ?  buttonColor : Colors.black38,
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(5)))),
//     );
//   }
// }

class BestMarcas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<BrandControllerGetx>(
      builder: (BrandControllerGetx controller) {
        return controller.brands.length != 0 ?  Container(
          margin: EdgeInsets.only(right: SizeConfig.scaleWidth(16)),
          height: SizeConfig.scaleHeight(151),
          width: double.infinity,
          child: ListView.builder(
            controller: controller.scroll,
              itemCount: controller.brands.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarsWithBrands(
                                brandId: controller.brands[index].id,
                                brandName: controller.brands[index].name,
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: SizeConfig.scaleWidth(16)),
                    height: SizeConfig.scaleHeight(149),
                    width: SizeConfig.scaleWidth(149),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConfig.scaleHeight(20)),
                        border: Border.all(color: Color(0XFFF45F5B)),
                        image: DecorationImage(
                          image: NetworkImage(controller.brands[index].image),
                        )),
                  ),
                );
              }),
        ) : CircularProgressIndicator();
      },
    );
  }
}

class NewAndUsedButtons extends StatefulWidget {
  String isOld;


  NewAndUsedButtons({ required this.isOld});

  @override
  _NewAndUsedButtonsState createState() => _NewAndUsedButtonsState();
}

class _NewAndUsedButtonsState extends State<NewAndUsedButtons> {
    bool selectNew = false;
  bool selectOld = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.scaleHeight(27),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.isOld = "1";
                  selectNew = true;
                  selectOld = false;
                });
              },
              child: Text(
                'جديد',
                style: TextStyle(
                    fontFamily: 'Bahij',
                    fontSize: SizeConfig.scaleTextFont(14)),
              ),
              style: ElevatedButton.styleFrom(
                primary: selectNew ? Color(0XFFF32608) : Color(0XFFFB9211),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      SizeConfig.scaleHeight(7),
                    ),
                    bottomRight: Radius.circular(SizeConfig.scaleHeight(7)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                  setState(() {
                    widget.isOld = "0";
                    selectNew = false;
                    selectOld = true;
                  });
                },
              child: Text(
                'مستخدم',
                style: TextStyle(
                    fontFamily: 'Bahij',
                    fontSize: SizeConfig.scaleTextFont(14)),
              ),
              style: ElevatedButton.styleFrom(
                primary: selectOld ?  Color(0XFFF32608) : Color(0XFFFB9211),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      SizeConfig.scaleHeight(7),
                    ),
                    bottomLeft: Radius.circular(SizeConfig.scaleHeight(7)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class NewAndUsedButtons extends StatelessWidget {
//   String isOld;

//
//   NewAndUsedButtons({required this.isOld});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: SizeConfig.scaleHeight(27),
//       width: double.infinity,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 isOld = "0";
//                 selectNew = true;
//                 selectOld = false;
//               },
//               child: Text(
//                 'جديد',
//                 style: TextStyle(
//                     fontFamily: 'Bahij',
//                     fontSize: SizeConfig.scaleTextFont(14)),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: selectNew ? Color(0XFFF32608) : Color(0XFFFB9211),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(
//                       SizeConfig.scaleHeight(7),
//                     ),
//                     bottomRight: Radius.circular(SizeConfig.scaleHeight(7)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 isOld = "1";
//                 selectNew = false;
//                 selectOld = true;
//                 },
//               child: Text(
//                 'مستخدم',
//                 style: TextStyle(
//                     fontFamily: 'Bahij',
//                     fontSize: SizeConfig.scaleTextFont(14)),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: selectOld ?  Color(0XFFF32608) : Color(0XFFFB9211),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(
//                       SizeConfig.scaleHeight(7),
//                     ),
//                     bottomLeft: Radius.circular(SizeConfig.scaleHeight(7)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MainTetField extends StatelessWidget {
  final String? titleText;
  final TextEditingController? textEditingController;

  const MainTetField({this.titleText, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.scaleHeight(12)),
      padding: EdgeInsets.only(
        right: SizeConfig.scaleWidth(17),
        top: SizeConfig.scaleHeight(4),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          SizeConfig.scaleHeight(7),
        ),
      ),
      height: SizeConfig.scaleHeight(27),
      child: TextField(
          // controller: textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: 0,
                top: 0
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
            ),
            hintText: titleText,
            hintStyle: TextStyle(
                fontSize: SizeConfig.scaleTextFont(14), fontFamily: 'Bahij'),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red,
                width: 0,
              ),


            ),
          )
          // InputDecoration(
          //   hintText: 'نوع السيارة',
          //   contentPadding: EdgeInsets.all(7),
          //   hintStyle: TextStyle(
          //       fontSize: SizeConfig.scaleTextFont(14)),
          //
          //   counterText: ' ',
          //   filled: true,
          //   fillColor: Colors.blue,
          //   border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10),
          //       borderSide: BorderSide.none),
          //
          //   // enabledBorder:
          //   //     _getBorder(color: Colors.white),
          //   // focusedBorder:
          //   //     _getBorder(color: Colors.white),
          //   // errorBorder:
          //   //     _getBorder(color: Colors.white),
          //   // errorText: 'ds',
          //   errorMaxLines: 1,
          //   // prefixIcon: prefixIcon,
          //   // suffixIcon: suffixIcon,
          // ),
          ),
    );
  }
}

OutlineInputBorder _getBorder({Color color: Colors.grey}) {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: color),
      borderRadius: BorderRadius.circular(15));
}
