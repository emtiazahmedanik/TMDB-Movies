import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:tmdbmovies/ui/controllers/popular_movies_controller.dart';
import 'package:tmdbmovies/ui/controllers/trending_movies_controller.dart';
import 'package:tmdbmovies/ui/controllers/upcoming_movies_controller.dart';

class UpcomingMoviesTab extends StatefulWidget {
  const UpcomingMoviesTab({super.key});

  @override
  State<UpcomingMoviesTab> createState() => _UpcomingMoviesTabState();
}

class _UpcomingMoviesTabState extends State<UpcomingMoviesTab>
    with AutomaticKeepAliveClientMixin {
  final _upcomingMoviesController = Get.find<UpcomingMoviesController>();
  final _gridController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getTrendingMovies();
    _gridController.addListener((){
      if(_gridController.position.maxScrollExtent == _gridController.offset){
        _upcomingMoviesController.getNewUpcomingMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<UpcomingMoviesController>(
      builder: (_) {
        return Visibility(
          visible: _upcomingMoviesController.getIsLoading == false,
          replacement: Center(child: const CircularProgressIndicator()),
          child:GridView.builder(
            controller: _gridController,
            itemCount: _upcomingMoviesController.getTrendingList.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext ctx, index) {
              if (index < _upcomingMoviesController.getTrendingList.length) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "${Urls.posterPathBaseUrl}${_upcomingMoviesController
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
    final bool isSuccess = await _upcomingMoviesController.getUpcomingMovies();
    if (isSuccess) {} else {
      Get.snackbar(
        "Error",
        _upcomingMoviesController.getErrorMag,
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

