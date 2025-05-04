import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:tmdbmovies/ui/controllers/now_playing_movies_controller.dart';
import 'package:tmdbmovies/ui/controllers/popular_movies_controller.dart';

class PopularMoviesTab extends StatefulWidget {
  const PopularMoviesTab({super.key});

  @override
  State<PopularMoviesTab> createState() => _PopularMoviesTabState();
}

class _PopularMoviesTabState extends State<PopularMoviesTab>
    with AutomaticKeepAliveClientMixin {
  final _popularMoviesController = Get.find<PopularMoviesController>();
  final _gridController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getTrendingMovies();
    _gridController.addListener((){
      if(_gridController.position.maxScrollExtent == _gridController.offset){
        _popularMoviesController.getNewPopularMovies();
      }
    });
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
            controller: _gridController,
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
                      image: NetworkImage(
                        "${Urls.posterPathBaseUrl}${_popularMoviesController
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

