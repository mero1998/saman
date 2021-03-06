import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imageview360_nullsafe/imageview360_nullsafe.dart';
import 'package:saman_project/api/api_settings.dart';
import 'package:saman_project/contorller/car_controller_api.dart';
import 'package:saman_project/contorller/cart_controller.dart';
import 'package:saman_project/getx/car_details_getx_controller.dart';
import 'package:saman_project/getx/cars_controller_getx.dart';
import 'package:saman_project/getx/cart_getx_controller.dart';
import 'package:saman_project/models/cars.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/product-widgt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetails extends StatefulWidget {
  Cars cars;
  ProductDetails({required this.cars});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late PageController pageController;
  int indexPage = 0;

  bool os = false;
  bool os2 = false;
  bool os3 = false;

  bool inner = true;
  bool outer = false;
  bool images = false;

  // bool autoRotate = true;
  // List<ImageProvider> imageList = <ImageProvider>[];
  // int rotationCount = 2;
  // int swipeSensitivity = 2;
  // bool allowSwipeToRotate = true;
  // RotationDirection rotationDirection = RotationDirection.anticlockwise;
  // Duration frameChangeDuration = Duration(milliseconds: 50);
  // bool imagePrecached = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    Get.put(CarDetailsGetxController());
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    CarDetailsGetxController.to.carDetails.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();

    CarDetailsGetxController.to.carDetailsIndex(widget.cars.id);
    return GetX<CarDetailsGetxController>(
      // didChangeDependencies: (state) {
      //   state.controller!.carDetails.clear();
      //   state.controller!.carDetailsIndex(widget.cars.id);
      // },
      autoRemove: true,
      dispose: (state) {
        print("dipose");
        state.controller!.carDetails.clear();
        state.controller!.carDetailsIndex(widget.cars.id);
      },
      builder: (CarDetailsGetxController controller) {
        print(widget.cars.id);
        return controller.carDetails.length != 0
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: kPrimaryColor),
                  title: Text(
                    controller.carDetails
                        .firstWhere((element) => element!.id == widget.cars.id)!
                        .name,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Bahij',
                        fontWeight: FontWeight.normal),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.scaleHeight(261),
                        child: Stack(
                          children: [
                            Visibility(
                                visible: inner,
                                child: Image.network(ApiSettings.BASE_URL +
                                    controller.carDetails
                                        .firstWhere((element) =>
                                            element!.id == widget.cars.id)!
                                        .interior_image)),
                            Visibility(
                              visible: outer,
                              child: WebView(
                                initialUrl: controller.carDetails
                                    .firstWhere((element) =>
                                        element!.id == widget.cars.id)!
                                    .iframe,
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated:
                                    (WebViewController webViewController) {
                                  _controller.complete(webViewController);
                                },
                                onProgress: (int progress) {
                                  print(
                                      "WebView is loading (progress : $progress %)");
                                },
                                onPageStarted: (String url) {
                                  print('Page started loading: $url');
                                },
                                onPageFinished: (String url) {
                                  print('Page finished loading: $url');
                                },
                                gestureNavigationEnabled: true,
                              ),
                            ),
                            //normal photo
                            Visibility(
                              visible: images,
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: controller.carDetails
                                    .firstWhere((element) =>
                                        element!.id == widget.cars.id)
                                    ?.images
                                    .length,
                                onPageChanged: (index) {
                                  setState(() {
                                    indexPage = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  var list = controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .images;
                                  // return Container();
                                  // imageList.add(NetworkImage(controller.carDetails.first!.images[index].picUrl));
                                  // return  Image.network( list.length != 0 ? list[index].picUrl : "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640", fit: BoxFit.cover,);
                                  return CachedNetworkImage(
                                    imageUrl: list[index].picUrl ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: double.infinity,
                                      // height: SizeConfig.scaleHeight(95),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.scaleHeight(28)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) {
                                      return Container(
                                          width: double.infinity,
                                          height: SizeConfig.scaleHeight(95),
                                          decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "???? ???????? ?????? ????????????",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.scaleTextFont(
                                                        25),
                                                color: Colors.black),
                                          ));
                                    },
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .images
                                      .length !=
                                  0,
                              child: PositionedDirectional(
                                end: SizeConfig.scaleWidth(17),
                                top: SizeConfig.scaleHeight(15),
                                child: Column(
                                  // shrinkWrap: true,
                                  // physics: ScrollPhysics(),
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          pageController.previousPage(
                                              duration:
                                                  Duration(microseconds: 500),
                                              curve: Curves.easeInBack);
                                          indexPage == 0
                                              ? pageController.jumpToPage(
                                                  controller
                                                          .carDetails
                                                          .firstWhere(
                                                              (element) =>
                                                                  element!.id ==
                                                                  widget
                                                                      .cars.id)!
                                                          .images
                                                          .length -
                                                      1)
                                              : null;
                                        },
                                        icon: Icon(
                                          Icons.arrow_upward,
                                          color: Colors.white,
                                          size: SizeConfig.scaleWidth(13),
                                        )),
                                    Container(
                                      width: SizeConfig.scaleWidth(50),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: controller.carDetails
                                            .firstWhere((element) =>
                                                element!.id == widget.cars.id)!
                                            .images
                                            .length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i <
                                                      controller.carDetails
                                                          .firstWhere(
                                                              (element) =>
                                                                  element!.id ==
                                                                  widget
                                                                      .cars.id)!
                                                          .images
                                                          .length;
                                                  i++) {
                                                pageController.jumpToPage(i);
                                              }
                                            },
                                            child: Container(
                                              width: SizeConfig.scaleWidth(63),
                                              height:
                                                  SizeConfig.scaleHeight(41),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          SizeConfig
                                                              .scaleHeight(10)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          controller
                                                                  .carDetails
                                                                  .first!
                                                                  .images[index]
                                                                  .picUrl ??
                                                              ""),
                                                      fit: BoxFit.cover)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          pageController.nextPage(
                                              duration:
                                                  Duration(microseconds: 500),
                                              curve: Curves.easeInBack);
                                          indexPage ==
                                                  controller.carDetails
                                                          .firstWhere(
                                                              (element) =>
                                                                  element!.id ==
                                                                  widget
                                                                      .cars.id)!
                                                          .images
                                                          .length -
                                                      1
                                              ? pageController.jumpToPage(0)
                                              : null;
                                        },
                                        icon: Icon(
                                          Icons.arrow_downward,
                                          color: Colors.white,
                                          size: SizeConfig.scaleWidth(13),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              start: 0,
                              end: 0,
                              bottom: SizeConfig.scaleHeight(13),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      changeState(
                                          inner: false,
                                          outer: false,
                                          images: true);
                                    },
                                    child: Image.asset(
                                      "images/images.png",
                                      height: SizeConfig.scaleHeight(24),
                                      width: SizeConfig.scaleWidth(24),
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(13),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        changeState(
                                            inner: false,
                                            outer: true,
                                            images: false);
                                      },
                                      child: Image.asset(
                                        "images/outer.png",
                                        height: SizeConfig.scaleHeight(24),
                                        width: SizeConfig.scaleWidth(24),
                                      )),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(13),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        changeState(
                                            inner: true,
                                            outer: false,
                                            images: false);
                                      },
                                      child: Image.asset(
                                        "images/inner.png",
                                        height: SizeConfig.scaleHeight(24),
                                        width: SizeConfig.scaleWidth(24),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ImageWithStack(),
                      TitleAndPrice(
                        title: controller.carDetails
                            .firstWhere(
                                (element) => element!.id == widget.cars.id)!
                            .name,
                        price: controller.carDetails
                            .firstWhere(
                                (element) => element!.id == widget.cars.id)!
                            .price,
                      ),
                      //Two Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.scaleWidth(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonW(
                              onTap: () {
                                CartGetxController.to.addToCart(
                                    carId: widget.cars.id.toString());
                                Navigator.pushNamed(
                                    context, "/checkout_screen");
                              },
                              title: Text(
                                '?????????? ????????',
                                style: TextStyle(
                                    fontSize: SizeConfig.scaleTextFont(18),
                                    fontFamily: 'Bahij',
                                    color: Colors.white),
                              ),
                              btnColor: kPrimaryColor,
                            ),
                            ButtonW(
                              onTap: () {
                                CartGetxController.to.addToCart(
                                    carId: widget.cars.id.toString());
                              },
                              title: Text(
                                '?????? ?????? ??????????',
                                style: TextStyle(
                                    fontSize: SizeConfig.scaleTextFont(18),
                                    fontFamily: 'Bahij',
                                    color: Colors.black),
                              ),
                              btnColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      //one
                      DropDownButton(
                        title: '?????? ????????????',
                        onTap: () {
                          setState(() {
                            os = true;
                            os2 = false;
                            os3 = false;
                            print('show');
                          });
                        },
                      ),
                      Visibility(
                        visible: os ? true : false,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.scaleWidth(16),
                              vertical: SizeConfig.scaleHeight(20)),
                          width: SizeConfig.scaleWidth(344),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.scaleHeight(12)),
                              border:
                                  Border.all(color: kPrimaryColor, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.scaleHeight(11),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.scaleWidth(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          '?????? ????????????',
                                          style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize:
                                                SizeConfig.scaleTextFont(16),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              os = false;
                                            });
                                          },
                                          child: Icon(Icons.close)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(5),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.scaleWidth(15)),
                                  child: Text(
                                    controller.carDetails
                                        .firstWhere((element) =>
                                            element!.id == widget.cars.id)!
                                        .description,
                                    style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: SizeConfig.scaleTextFont(14)),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(19),
                                ),
                                DetailsLine(
                                  icon: Icons.edit_road,
                                  firstTitle: '??????????????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .mileage,
                                ),
                                DetailsLine(
                                  icon: Icons.local_gas_station_outlined,
                                  firstTitle: '?????? ????????????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .fuelType,
                                ),
                                DetailsLine(
                                  icon: Icons.invert_colors_on_outlined,
                                  firstTitle: '?????????? ??????????????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .interColor,
                                ),
                                DetailsLine(
                                  icon: Icons.invert_colors_on_outlined,
                                  firstTitle: '?????????? ??????????????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .color,
                                ),
                                DetailsLine(
                                  icon: Icons.calendar_today_outlined,
                                  firstTitle: '?????????? ??????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .modelYear,
                                ),
                                DetailsLine(
                                  icon: Icons.local_gas_station_outlined,
                                  firstTitle: '?????????? ????????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .fuelConsumption,
                                ),
                                DetailsLine(
                                  icon: Icons.car_repair,
                                  firstTitle: '???????? ????????????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .transmission,
                                ),
                                DetailsLine(
                                  icon: Icons.card_membership_sharp,
                                  firstTitle: '????????',
                                  lastTitle: controller.carDetails
                                      .firstWhere((element) =>
                                          element!.id == widget.cars.id)!
                                      .engine,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //two
                      DropDownButton(
                          title: '?????????? ????????????',
                          onTap: () {
                            setState(() {
                              os2 = true;
                              os = false;
                              os3 = false;
                            });
                          }),
                      Visibility(
                        visible: os2 ? true : false,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.scaleWidth(16),
                              vertical: SizeConfig.scaleHeight(20)),
                          width: SizeConfig.scaleWidth(344),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.scaleHeight(12)),
                              border:
                                  Border.all(color: kPrimaryColor, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.scaleHeight(11),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.scaleWidth(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(''),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              os2 = false;
                                            });
                                          },
                                          child: Icon(Icons.close)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.scaleWidth(15)),
                                  child: Text(
                                    controller.carDetails
                                            .firstWhere((element) =>
                                                element!.id == widget.cars.id)!
                                            .features ??
                                        "N/A",
                                    style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: SizeConfig.scaleTextFont(16),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //three
                      DropDownButton(
                          title: '?????????????? ????????????',
                          onTap: () {
                            setState(() {
                              os3 = true;
                              os2 = false;
                              os = false;
                            });
                          }),
                      Visibility(
                        visible: os3 ? true : false,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.scaleWidth(16),
                              vertical: SizeConfig.scaleHeight(20)),
                          width: SizeConfig.scaleWidth(344),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.scaleHeight(12)),
                              border:
                                  Border.all(color: kPrimaryColor, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.scaleHeight(11),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.scaleWidth(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "${controller.carDetails.firstWhere((element) => element!.id == widget.cars.id)!.address}   - ${controller.carDetails.firstWhere((element) => element!.id == widget.cars.id)!.contact}",
                                          style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize:
                                                SizeConfig.scaleTextFont(16),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              os3 = false;
                                            });
                                          },
                                          child: Icon(Icons.close)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: SizeConfig.scaleHeight(20),
                              horizontal: SizeConfig.scaleWidth(16)),
                          child: Title(
                            title: '???????????? ???? ??????????',
                          )),
                      GetX<CarsGetxController>(
                          builder: (CarsGetxController carsController) {
                        return Visibility(
                          visible: CarsControllerApi().isExeption == false,
                          child: Container(
                              height: SizeConfig.scaleHeight(285),
                              width: double.infinity,
                              child: ListView.builder(
                                  itemCount: carsController.cars.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // carsController.showList();
                                    return Container(
                                        margin: EdgeInsets.only(
                                            right: SizeConfig.scaleWidth(16)),
                                        child: ProductWidget(
                                          cars: carsController.cars[index],
                                        ));
                                  })),
                        );
                      }),
                      // Container(
                      //   height: SizeConfig.scaleHeight(285),
                      //   width: double.infinity,
                      //   child: ListView.builder(
                      //       itemCount: 5,
                      //       scrollDirection: Axis.horizontal,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return Container(
                      //             margin: EdgeInsets.only(
                      //                 right:SizeConfig.scaleWidth(16) ),
                      //             child: ProductWidget());
                      //       }),
                      // ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(20),
                      )
                    ],
                  ),
                ),
              )
            : Scaffold(
                body: Center(
                child: CircularProgressIndicator(),
              ));
      },
    );
  }

  void changeState(
      {required bool inner, required bool outer, required bool images}) {
    setState(() {
      this.inner = inner;
      this.outer = outer;
      this.images = images;
    });
  }
}

class DropDownButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const DropDownButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(15)),
        height: SizeConfig.scaleHeight(36),
        width: SizeConfig.scaleWidth(343),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: kPrimaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(
                14,
              ),
              vertical: SizeConfig.scaleHeight(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title',
                style: TextStyle(
                    fontSize: SizeConfig.scaleTextFont(18),
                    color: Colors.white,
                    fontFamily: 'Bahij'),
              ),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAndPrice extends StatelessWidget {
  String title;
  String price;

  TitleAndPrice({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Bahij',
              fontSize: SizeConfig.scaleTextFont(20),
            ),
          ),
          Text(
            "$price ????????",
            style: TextStyle(
              color: Color(0XFFF45F5B),
              fontFamily: 'Bahij',
              fontSize: SizeConfig.scaleTextFont(20),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWithStack extends StatelessWidget {
  const ImageWithStack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.scaleHeight(259),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeConfig.scaleHeight(28),
        ),
        image: DecorationImage(
          image: AssetImage('images/carr.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                SizeConfig.scaleHeight(28),
              ),
              color: Colors.black26,
            ),
          ),
          Positioned(
            left: SizeConfig.scaleWidth(17),
            top: SizeConfig.scaleHeight(22),
            bottom: SizeConfig.scaleHeight(22),
            child: Container(
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.scaleHeight(2)),
                    height: SizeConfig.scaleHeight(165),
                    width: SizeConfig.scaleWidth(64),
                    // color: Colors.greenAccent,
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: SizeConfig.scaleHeight(5),
                            ),
                            height: SizeConfig.scaleHeight(41),
                            width: SizeConfig.scaleWidth(63),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.scaleHeight(6)),
                                image: DecorationImage(
                                    image: AssetImage('images/carr.jpg'),
                                    fit: BoxFit.cover)),
                          );
                        }),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: SizeConfig.scaleHeight(12.5),
              left: SizeConfig.scaleWidth(140),
              right: SizeConfig.scaleWidth(140),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        print('fdf');
                      },
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )),
                  GestureDetector(
                      onTap: () {
                        print('fdf');
                      },
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )),
                  GestureDetector(
                      onTap: () {
                        print('fdf');
                      },
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}

class DetailsLine extends StatelessWidget {
  final IconData? icon;
  final String? firstTitle;
  final String? lastTitle;

  const DetailsLine({this.icon, this.firstTitle, this.lastTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(2)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: SizeConfig.scaleWidth(4)),
            width: SizeConfig.scaleWidth(147),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: SizeConfig.scaleWidth(2.9),
                ),
                Text(
                  '$firstTitle',
                  style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: SizeConfig.scaleTextFont(18)),
                )
              ],
            ),
          ),
          Container(
            color: kPrimaryColor,
            width: SizeConfig.scaleWidth(104),
            height: 2,
            child: Divider(
              color: kPrimaryColor,
              thickness: 1.0,
              indent: 1,
              height: SizeConfig.scaleHeight(20),
            ),
          ),
          SizedBox(
            width: SizeConfig.scaleWidth(10),
          ),
          Container(
            alignment: Alignment.center,
            width: SizeConfig.scaleWidth(68),
            child: Text('$lastTitle',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bahij',
                    fontSize: SizeConfig.scaleTextFont(16))),
          ),
        ],
      ),
    );
  }
}

class ButtonW extends StatelessWidget {
  final Widget? title;
  final Color? btnColor;
  final VoidCallback? onTap;

  const ButtonW({this.title, this.btnColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: title,
      style: ElevatedButton.styleFrom(
        primary: btnColor,
        minimumSize: Size(
          SizeConfig.scaleWidth(165),
          SizeConfig.scaleHeight(36),
        ),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizeConfig.scaleHeight(12),
          ),
        ),
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
      child: Text(
        '$title',
        style: TextStyle(
            fontSize: SizeConfig.scaleTextFont(20), fontFamily: 'Bahij'),
      ),
    );
  }
}
