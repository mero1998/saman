import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saman_project/contorller/address_api_controller.dart';
import 'package:saman_project/models/address.dart';


class AddressGetxController extends GetxController {

  RxList<Address?> addresses = <Address?>[].obs;
  RxBool isLoading = true.obs;
  AddressApiController addressesController = AddressApiController();
  static AddressGetxController get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    readAddress();
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    addresses.clear();
    super.onClose();
  }


    Future<bool> addAddress({required String firstName ,required String lastName, required String postalCode, required String city,required String area,required String street}) async{
     Address? addressObj = await addressesController.addNewAddress(firstName: firstName, lastName: lastName, postalCode: postalCode, city: city, area: area, street: street);
     if(addressObj != null){
     //  addressObj.id = address.id;
       isLoading.value = true;
       addresses.add(addressObj);
       print("Added");
       isLoading.value = false;

     }
     return addressObj != null;
     }


  Future<void> readAddress() async{
    Address? address = await addressesController.indexAddress();
    addresses.add(address);

  }


  // int getAddressId(){
  //   int index = addresses.indexWhere((element) => element.isSelected == true);
  //   return isSelected.value ? addresses[index].id : 0;

  // }


}