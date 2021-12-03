import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/contorller/car_controller_api.dart';
import 'package:saman_project/contorller/search_controller_api.dart';
import 'package:saman_project/models/cars.dart';
import 'package:saman_project/models/cart.dart';

class CarsGetxController extends GetxController  with StateMixin<List<Cars>>, ScrollMixin{
  RxList<Cars> cars = <Cars>[].obs;
  RxList<Cars> newCars = <Cars>[].obs;
  RxList<Cars> oldCars = <Cars>[].obs;
  RxList<Cars> carsFilter = <Cars>[].obs;
  RxList<Cars> showCars = <Cars>[].obs;
  RxList<Cars> carsWithBrand = <Cars>[].obs;

  RxBool selectNew = false.obs;
  RxBool selectOld = false.obs;
  RxBool selectFilter = false.obs;


  final int perPage = 10;
  int page = 1;
  bool getFirstData = false;
  bool lastPage = false;

  static CarsGetxController get to => Get.find();
  CarsControllerApi carsControllerApi = CarsControllerApi();
  SearchControllerApi searchControllerApi = SearchControllerApi();

  @override
  void onInit() async {
    super.onInit();
    await findAllGitRepositories();
    showList();
  }

  Future<void> findAllGitRepositories() async {
    await carsControllerApi.indexCars(current_page:page , perPage:perPage).then((result){
      final bool emptyRepositories = result.isEmpty;
      if (!getFirstData && emptyRepositories) {
        // change(null, status: RxStatus.empty());
      } else if (getFirstData && emptyRepositories) {
        lastPage = true;
      } else {
        getFirstData = true;
        cars.addAll(result);
        // change(repositories, status: RxStatus.success());
      }
    }, onError: (err) {
      // change(null, status: RxStatus.error(err.toString()));
    });
  }

  // Future<void> indexCars() async {
  //   cars.value = await carsControllerApi.indexCars();
  //   print("From Index :${cars.value}");
  // }

  void getCarsWithBrand({required int brandId}) {
    print("Brand Id : $brandId");
    print(cars.length);
    if(cars.indexWhere((element) => element.brand!.id == brandId) != -1){
      print("True");
    }else{
      print("Fasle");
    }
    carsWithBrand.value = cars.where((e) => int.parse(e.brandId!) == brandId).toList();
    print("From Getx: ${carsWithBrand.length}");
    print(cars.first.brand!.name);
    print(cars.first.brand!.id);

  }

  void getCars() {
    if (selectNew.value) {
      newCars.value = cars.where((e) => e.isOld == "1").toList();
    } else if (selectOld.value) {
      oldCars.value = cars.where((e) => e.isOld == "0").toList();
    } else if (selectFilter.value) {
      //e.price == RangeValues(double.parse(fromPrice),double.parse(toPrice)),
      carsFilter.value;
      // carsFilter.value =  cars.where((e) => e.color == "black").toList();
      print(carsFilter.length);
    } else {
      showCars.value = cars;
    }
  }

  Future<void> getFilterCar({
    required String model,
    required String color,
    required String isOld,
    required String type,
    required String price_from,
    required String price_to,
  }) async {
    carsFilter.value = await searchControllerApi.indexSearch(
        model: model,
        type: type,
        price_from: price_from,
        price_to: price_to,
        isOld: isOld,
        color: color);
    // carsFilter.value =  cars.where((e) => e.brand!.name.contains(type) ||
    //     e.color!.contains(color) && e.modelYear == model  && e.isOld == isOld && e.price! == price).toList();
    print("Length: ${carsFilter.length}");
  }

  int getListLength() {
    if (selectNew.value) {
      return newCars.length;
    } else if (selectOld.value) {
      return oldCars.length;
    } else if (selectFilter.value) {
      return carsFilter.length;
    } else {
      return cars.length;
    }
  }

  // Future<void> indexOldCars() async{
  //   // cars.value.where((e) => e.isOld != isOld);\
  //   cars.value = await carsControllerApi.indexOldCars();
  //
  //   print("Old CARS Length: ${cars.length}");
  // }
  // Future<void> indexNewCars() async{
  //   cars.value = await carsControllerApi.indexNewCars();
  //   print("New CARS Length: ${cars.length}");
  //
  // }

  Future<void> indexFilterCars(
      {required String isOld,
      required String model,
      required String price_from,
      required String price_to,
      required String brand_id,
      required String color}) async {
    carsFilter.value = await carsControllerApi.indexCarsFilter(
      isOld: isOld,
      color: color,
      brand_id: brand_id,
      model: model,
      price_from: price_from,
      price_to: price_from,
    );
  }

  void changeNewState(bool state) {
    selectNew.value = state;
    selectOld.value = !state;
    selectFilter.value = !state;
  }

  void changeOldState(bool state) {
    selectOld.value = state;
    selectNew.value = !state;
    selectFilter.value = !state;
  }

  void changeFilterState(bool state) {
    selectFilter.value = state;
    selectNew.value = !state;
    selectOld.value = !state;
  }

  List<Cars> showList() {
    if (selectNew.value) {
      print("new selected");
      return showCars = newCars;
    } else if (selectOld.value) {
      print("Old selected");
      return showCars = oldCars;
    } else if (selectFilter.value) {
      print("Filter selected");
      return showCars = carsFilter;
    } else {
      print("ShowCars selected");
      print(cars.length);
      return showCars.value = cars;
    }
  }


  @override
  Future<void> onEndScroll() async {
    // TODO: implement onEndScroll
    print('onEndScroll');
    if (!lastPage) {
      page += 1;
      Get.dialog(Center(child: LinearProgressIndicator()));
      await findAllGitRepositories();
      Get.back();
    } else {
      Get.snackbar('Alert', 'End of Repositories');
    }
  }

  @override
  Future<void> onTopScroll() async{
    // TODO: implement onTopScroll
    print('onTopScroll');
  }

}
