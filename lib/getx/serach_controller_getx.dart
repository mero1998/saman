import 'package:get/get.dart';
import 'package:saman_project/contorller/blog_controller_api.dart';
import 'package:saman_project/contorller/search_controller_api.dart';
import 'package:saman_project/models/blog.dart';
import 'package:saman_project/models/colors.dart';
import 'package:saman_project/models/models.dart';

class SearchControllerGetx extends GetxController{

  RxList<ColorsCars> colors = <ColorsCars>[].obs;
  RxList<ModelsCars> models = <ModelsCars>[].obs;

  SearchControllerApi seaarchControllerApi = SearchControllerApi();

 static SearchControllerGetx get to => Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    indexColors();
    indexModels();
  }


  Future<void> indexColors() async{
    colors.value = await seaarchControllerApi.indexColors();
  }

  Future<void> indexModels() async{
    models.value = await seaarchControllerApi.indexModels();
  }


}

