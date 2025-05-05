import 'package:get/get.dart';
import 'package:tmdbmovies/ui/controllers/home_screen_controller.dart';
import 'package:tmdbmovies/ui/controllers/now_playing_movies_controller.dart';
import 'package:tmdbmovies/ui/controllers/popular_movies_controller.dart';
import 'package:tmdbmovies/ui/controllers/trending_movies_controller.dart';
import 'package:tmdbmovies/ui/controllers/upcoming_movies_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(NowPlayingMoviesController());
    Get.put(PopularMoviesController());
    Get.put(TrendingMoviesController());
    Get.put(UpcomingMoviesController());
    Get.put(HomeScreenController());
  }

}