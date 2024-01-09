
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
  List<ArticleModel> filteredArticles=[];
  bool isSearching = false;

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

  @override
  void searchArticles(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all posts
      filteredArticles = articles.toList(); // Assign a copy of all articles
    } else {
      // Filter posts based on the search query within the already filteredPosts
      filteredArticles = articles.where((article) {
        bool titleMatch =
            article.title != null && article.title!.toLowerCase().contains(query.toLowerCase());
        bool authorNameMatch =
            article.author != null && article.author!.toLowerCase().contains(query.toLowerCase());
        return titleMatch || authorNameMatch;
      }).toList();
    }
   // print("What what what");
   // print("1/9/2024 Saeed");
    update();
  }
  void  cancelSearch(){
    isSearching = false;
    resetSearch();
    update();
  }
  void resetSearch() {
    filteredArticles.clear();
    update();
  }

}
