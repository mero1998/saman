import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/getx/address_getx_controller.dart';
import 'package:saman_project/screens/payment/revision.dart';
import 'package:saman_project/utils/app_color.dart';
import 'package:saman_project/utils/constans.dart';
import 'package:saman_project/utils/size-config.dart';
import 'package:saman_project/widgets/my-small-button.dart';

import 'adress_screen.dart';
import 'choose-pay-method.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<bool> _isDisabled = [false, false, false];
  int indexxx = 0;
int tabIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    _tabController.addListener((){
      tabIndex = _tabController.index;
      setState((){});
      // if (_tabController.index == 1) {
      //   print('nope!');
      //   setState(() {
      //     _tabController.index = 0;
      //   });
      // }
    });
    Get.put(AddressGetxController());
  }

  onTap() {
    if (_isDisabled[_tabController.index]) {
      int index = _tabController.previousIndex;
      setState(() {
        _tabController.index = index;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kSecondaryColor),
        title: Text(
          'الدفع',
          style: TextStyle(color: kPrimaryColor),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
      decoration: BoxDecoration(
        border: Border.all(
       color:Color(0xffF45F5B),
    ),
      ),
            child: Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Container(
                    height: 45,
                    color:index == tabIndex? Color(0xffF45F5B):Colors.white,
                    alignment: Alignment.center,
                    child: Text(index == 0 ? "العنوان" : index == 1 ? "مراجعة" : "الدفع",
                    style: TextStyle(
                       color:index == tabIndex? Colors.white:Color(0xffF45F5B),
                      fontFamily: "Cairo",
                      fontSize: index == tabIndex ? 16 : 14,
                    ),

                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                AddressScreen(
                  tabController: _tabController,
                ),
                Revision(
                  tabController: _tabController,
                ),
                ChoosePayMethod(
                  tabController: _tabController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
