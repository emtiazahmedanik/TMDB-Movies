import 'package:tmdbmovies/data/model/contentModel.dart';

class TrendingListModel {
  final int page;
  final List<ContentModel> trendingList;

  TrendingListModel({required this.page, required this.trendingList});

  factory TrendingListModel.fromJson(Map<String, dynamic> jsonData) {
    List<ContentModel> tempTrendingList = [];
    if(jsonData["results"] != null){
      for(Map<String,dynamic> data in jsonData["results"]){
        tempTrendingList.add(ContentModel.fromJson(data));
      }
    }
    return TrendingListModel(
      page: jsonData["page"],
      trendingList: tempTrendingList
    );
  }
}
