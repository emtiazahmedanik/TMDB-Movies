import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:tmdbmovies/ui/controllers/trending_movies_controller.dart';

class TrendingMoviesTab extends StatefulWidget {
  const TrendingMoviesTab({super.key});

  @override
  State<TrendingMoviesTab> createState() => _TrendingMoviesTabState();
}

class _TrendingMoviesTabState extends State<TrendingMoviesTab>
    with AutomaticKeepAliveClientMixin {
  final _trendingMoviesController = Get.find<TrendingMoviesController>();

  @override
  void initState() {
    super.initState();
    _getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<TrendingMoviesController>(
      builder: (_) {
        return Visibility(
          visible: _trendingMoviesController.getIsLoading == false,
          replacement: Center(child: const CircularProgressIndicator()),
          child: GridView.builder(
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
                      image: CachedNetworkImageProvider(
                        "${Urls.posterPathBaseUrl}${_trendingMoviesController.getTrendingList[index].poster_path}",
                      ),
                      // NetworkImage(
                      //   "${Urls.posterPathBaseUrl}${_trendingMoviesController
                      //       .getTrendingList[index].poster_path}",
                      // ),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_trendingMoviesController.getTrendingList[index].release_date,style: TextStyle(color: Colors.amberAccent,fontSize: 10,fontWeight: FontWeight.w500),),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                              child: Text(
                                "⭐ " +
                                    _trendingMoviesController
                                        .getTrendingList[index]
                                        .vote_avg
                                        .toString(),
                                style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _trendingMoviesController.getNewTrendingMovies();
                      },
                      label: Icon(Icons.refresh),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Future<void> _getTrendingMovies() async {
    final bool isSuccess = await _trendingMoviesController.getTrendingMovies();
    if (isSuccess) {
    } else {
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
  bool get wantKeepAlive => true;
}
