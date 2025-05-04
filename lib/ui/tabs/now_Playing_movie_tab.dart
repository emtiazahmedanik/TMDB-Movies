import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:tmdbmovies/ui/controllers/now_playing_movies_controller.dart';

class NowPlayingMovieTab extends StatefulWidget {
  const NowPlayingMovieTab({super.key});

  @override
  State<NowPlayingMovieTab> createState() => _NowPlayingMovieTabState();
}

class _NowPlayingMovieTabState extends State<NowPlayingMovieTab>
    with AutomaticKeepAliveClientMixin {
  final _nowPlayingMoviesController = Get.find<NowPlayingMoviesController>();
  final _gridController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getTrendingMovies();
    _gridController.addListener((){
      if(_gridController.position.maxScrollExtent == _gridController.offset){
        _nowPlayingMoviesController.getNewNowPlayingMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<NowPlayingMoviesController>(
      builder: (_) {
        return Visibility(
          visible: _nowPlayingMoviesController.getIsLoading == false,
          replacement: Center(child: const CircularProgressIndicator()),
          child:GridView.builder(
            controller: _gridController,
            itemCount: _nowPlayingMoviesController.getTrendingList.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext ctx, index) {
              if (index < _nowPlayingMoviesController.getTrendingList.length) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "${Urls.posterPathBaseUrl}${_nowPlayingMoviesController
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
    final bool isSuccess = await _nowPlayingMoviesController.getNowPlayingMovies();
    if (isSuccess) {} else {
      Get.snackbar(
        "Error",
        _nowPlayingMoviesController.getErrorMag,
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

