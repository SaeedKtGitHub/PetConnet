
import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/articles_screen_data.dart';
import 'package:pet_connect/data/model/article_model.dart';

abstract class ArticlesController extends GetxController {
  getAllArticles();
}

class ArticlesControllerImp extends ArticlesController {
  MyServices myServices = Get.find();
  ArticlesScreenData articlesScreenData = ArticlesScreenData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<ArticleModel> articles=[];

  @override
  getAllArticles() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response = await articlesScreenData.getAllArticles(
        myServices.sharedPreferences.getString("userID")!,
      );
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response[0]['status'] == "success") {
          List dataResponse = response[0]['data'];
              articles.clear();
          articles.addAll(dataResponse.map((e) => ArticleModel.fromJson(e)));
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (error) {
      statusRequest = StatusRequest.failure;
      print('Error fetching articles: $error');
    } finally {
      update();
    }
  }


 @override
  void onInit() {
    // TODO: implement onInit
   getAllArticles();
   //print(articles.length);
    super.onInit();
  }

}
