
import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class ArticlesScreenData{

  Crud crud;

  ArticlesScreenData(this.crud);


  getAllArticles(String userId) async {
    //TODO:Edit the method
    var response = await crud.postDataList(AppLink.getAllArticles, {
      "userID": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  //getSearched Articles

  getSearchedArticles(String userId,{required String query,required int limit}) async {
    //TODO:Edit the method
    var response = await crud.postDataList(AppLink.getSearchedArticles, {
      "userID": userId,
      "query":query,
      "limit":limit.toString()
    });
    return response.fold((l) => l, (r) => r);
  }



}