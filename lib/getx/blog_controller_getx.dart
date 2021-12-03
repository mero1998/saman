import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/contorller/blog_controller_api.dart';
import 'package:saman_project/models/blog.dart';

class BlogControllerGetx extends GetxController with StateMixin<List<Blog>>, ScrollMixin{

  RxList<Blog> blogs = <Blog>[].obs;

  final int perPage = 10;
  int page = 1;
  bool getFirstData = false;
  bool lastPage = false;

  BlogControllerApi blogControllerApi = BlogControllerApi();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    findAllGitRepositories();
  }


  // Future<void> indexBlog() async{
  //   blogs.value = await blogControllerApi.indexBlog();
  //
  // }

  Future<void> findAllGitRepositories() async {
    await blogControllerApi.indexBlog(current_page:page , perPage:perPage).then((result){
      final bool emptyRepositories = result.isEmpty;
      if (!getFirstData && emptyRepositories) {
        // change(null, status: RxStatus.empty());
      } else if (getFirstData && emptyRepositories) {
        lastPage = true;
      } else {
        getFirstData = true;
        blogs.addAll(result);
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

