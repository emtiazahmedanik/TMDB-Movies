import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:tmdbmovies/ui/controllers/popular_movies_controller.dart';

class PopularMoviesTab extends StatefulWidget {
  const PopularMoviesTab({super.key});

  @override
  State<PopularMoviesTab> createState() => _PopularMoviesTabState();
}

class _PopularMoviesTabState extends State<PopularMoviesTab>
    with AutomaticKeepAliveClientMixin {
  final _popularMoviesController = Get.find<PopularMoviesController>();

  @override
  void initState() {
    super.initState();
    _getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<PopularMoviesController>(
      builder: (_) {
        return Visibility(
          visible: _popularMoviesController.getIsLoading == false,
          replacement: Center(child: const CircularProgressIndicator()),
          child:GridView.builder(
            itemCount: _popularMoviesController.getTrendingList.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext ctx, index) {
              if (index < _popularMoviesController.getTrendingList.length) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider("${Urls.posterPathBaseUrl}${_popularMoviesController.getTrendingList[index].poster_path}"),
                      // NetworkImage(
                      //   "${Urls.posterPathBaseUrl}${_popularMoviesController
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
                          Text(_popularMoviesController.getTrendingList[index].release_date,style: TextStyle(color: Colors.amberAccent,fontSize: 10,fontWeight: FontWeight.w500),),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                              child: Text(
                                "⭐ " +
                                    _popularMoviesController
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
                return  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _popularMoviesController.getNewPopularMovies();
                      },
                      label: Icon(Icons.refresh),
                    ),
                  ),
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
    final bool isSuccess = await _popularMoviesController.getPopularMovies();
    if (isSuccess) {} else {
      Get.snackbar(
        "Error",
        _popularMoviesController.getErrorMag,
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

