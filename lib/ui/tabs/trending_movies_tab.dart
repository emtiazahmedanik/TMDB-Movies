import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:tmdbmovies/ui/controllers/popular_movies_controller.dart';
import 'package:tmdbmovies/ui/controllers/trending_movies_controller.dart';

class TrendingMoviesTab extends StatefulWidget {
  const TrendingMoviesTab({super.key});

  @override
  State<TrendingMoviesTab> createState() => _TrendingMoviesTabState();
}

class _TrendingMoviesTabState extends State<TrendingMoviesTab>
    with AutomaticKeepAliveClientMixin {
  final _trendingMoviesController = Get.find<TrendingMoviesController>();
  final _gridController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getTrendingMovies();
    _gridController.addListener((){
      if(_gridController.position.maxScrollExtent == _gridController.offset){
        _trendingMoviesController.getNewTrendingMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<TrendingMoviesController>(
      builder: (_) {
        return Visibility(
          visible: _trendingMoviesController.getIsLoading == false,
          replacement: Center(child: const CircularProgressIndicator()),
          child:GridView.builder(
            controller: _gridController,
            itemCount: _trendingMoviesController.getTrendingList.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext ctx, index) {
              if (index < _trendingMoviesController.getTrendingList.length) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "${Urls.posterPathBaseUrl}${_trendingMoviesController
                            .getTrendingList[index].poster_path}",
                      ),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: const Center(child: CircularProgressIndicator(),),
                );
              }
            },
          )
          ,
        );
      },
    );
  }

  Future<void> _getTrendingMovies() async {
    final bool isSuccess = await _trendingMoviesController.getTrendingMovies();
    if (isSuccess) {} else {
      Get.snackbar(
        "Error",
        _trendingMoviesController.getErrorMag,
        icon: Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>
      true;
}

