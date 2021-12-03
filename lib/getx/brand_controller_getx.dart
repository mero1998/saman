import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/contorller/brand_controller_api.dart';
import 'package:saman_project/models/brands.dart';

class BrandControllerGetx extends GetxController  with StateMixin<List<Brands>>, ScrollMixin {

  RxList<Brands> brands = <Brands>[].obs;
  // There is next page or not
  // RxBool _hasNextPage = true.obs;
  //
  // // Used to display loading indicators when _firstLoad function is running
  // RxBool _isFirstLoadRunning = false.obs;
  //
  // // Used to display loading indicators when _loadMore function is running
  // RxBool _isLoadMoreRunning = false.obs;

  final int perPage = 10;
  int page = 1;
  bool getFirstData = false;
  bool lastPage = false;
  BrandControllerApi brandControllerApi = BrandControllerApi();
  static BrandControllerApi get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("We are here");
    // readBrands();
    findAllGitRepositories();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> findAllGitRepositories() async {
    await brandControllerApi.indexBrands(current_page:page , perPage:perPage).then((result){
      final bool emptyRepositories = result.isEmpty;
      if (!getFirstData && emptyRepositories) {
        // change(null, status: RxStatus.empty());
      } else if (getFirstData && emptyRepositories) {
        lastPage = true;
      } else {
        getFirstData = true;
        brands.addAll(result);
        // change(repositories, status: RxStatus.success());
      }
    }, onError: (err) {
      // change(null, status: RxStatus.error(err.toString()));
    });
  }

  @override
  Future<void> onEndScroll() async {
    // TODO: implement onEndScroll
    print('onEndScroll');
    if (!lastPage) {
      page += 1;
      Get.dialog(Center(child: CircularProgressIndicator()));
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