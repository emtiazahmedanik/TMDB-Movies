import 'package:get/get.dart';
import 'package:tmdbmovies/data/model/contentModel.dart';
import 'package:tmdbmovies/data/model/trendingListModel.dart';
import 'package:tmdbmovies/data/service/networkClient.dart';
import 'package:tmdbmovies/data/utils/urls.dart';

class TrendingMoviesController extends GetxController {
  List<ContentModel> _trendingList = [];

  List get getTrendingList => _trendingList;
  bool _isLoading = false;

  get getIsLoading => _isLoading;
  String? _errorMsg;

  get getErrorMag => _errorMsg;

  bool isSuccess = false;

  //page=1
  int _page = 1;

  Future<bool> getTrendingMovies() async {
    _isLoading = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: "${Urls.trendingMoviesUrl}page=1",
    );
    if (response.isSuccess) {
      TrendingListModel trendingListModel = TrendingListModel.fromJson(
        response.data ?? {},
      );
      _trendingList = trendingListModel.trendingList;
      isSuccess = true;
      _errorMsg = null;
      if (_page == 1) {
        _page++;
      }
    } else {
      _errorMsg = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> getNewTrendingMovies() async {
    _isLoading = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: "${Urls.trendingMoviesUrl}page=$_page",
    );
    if (response.isSuccess) {
      TrendingListModel trendingListModel = TrendingListModel.fromJson(
        response.data ?? {},
      );
      _trendingList.addAll(trendingListModel.trendingList);
      isSuccess = true;
      _errorMsg = null;
      _page++;
    } else {
      _errorMsg = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
