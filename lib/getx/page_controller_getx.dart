import 'package:get/get.dart';
import 'package:saman_project/contorller/blog_controller_api.dart';
import 'package:saman_project/contorller/page_controller_api.dart';
import 'package:saman_project/models/blog.dart';
import 'package:saman_project/models/page.dart';

class PageControllerGetx extends GetxController{

  RxList<PageSetting> pages = <PageSetting>[].obs;

  PageControllerApi pageControllerApi = PageControllerApi();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    indexPages();
  }


  Future<void> indexPages() async{
    pages.value = await pageControllerApi.indexPages();
  }



}

