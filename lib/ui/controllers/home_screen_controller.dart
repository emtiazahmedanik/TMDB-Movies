import 'package:get/get.dart';
import 'package:tmdbmovies/data/model/contentModel.dart';
import 'package:tmdbmovies/data/model/trendingListModel.dart';
import 'package:tmdbmovies/data/service/networkClient.dart';
import 'package:tmdbmovies/data/utils/urls.dart';

class HomeScreenController extends GetxController{
  List<ContentModel> trendingList = [];
  int? _dropDownValue = 1;
  get getDropDownValue => _dropDownValue;
  set setDropDownValue(value) {
    trendingList.clear();
    _dropDownValue = value;
    update();
    callGetTrending();
  }
  bool _isLoading = false;
  get getIsLoading => _isLoading;
  String? _errorMsg;
  get getErrorMag => _errorMsg;
  bool isSuccess = false;

  Future<bool> getTrending() async {
    String url ;
    if(_dropDownValue == 1){
      url = Urls.trendingOfDay;
    }else{
      url = Urls.trendingOfWeek;
    }

    NetworkResponse response = await NetworkClient.getRequest(
      url: url,
    );
    if (response.isSuccess) {
      TrendingListModel trendingListModel = TrendingListModel.fromJson(
        response.data ?? {},
      );
      trendingList = trendingListModel.trendingList;
      isSuccess = true;
      _errorMsg = null;
    }else{
      _errorMsg = response.errorMessage;
    }
    update();

    return isSuccess;
  }

  Future<void> callGetTrending() async{
    await getTrending();
  }


}