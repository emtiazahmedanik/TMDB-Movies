import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tmdbmovies/data/model/contentModel.dart';
import 'package:tmdbmovies/data/model/trendingListModel.dart';
import 'package:tmdbmovies/data/service/networkClient.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:tmdbmovies/ui/screens/color.dart';
import 'package:tmdbmovies/ui/tabs/now_Playing_movie_tab.dart';
import 'package:tmdbmovies/ui/tabs/popular_movies_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getTrending();
  }

  List<ContentModel> _trendingList = [];

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: AppColors.deepBlue,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        _trendingList.isNotEmpty
                            ? CarouselSlider.builder(
                              itemCount: _trendingList.length,
                              itemBuilder:
                                  (
                                    BuildContext context,
                                    int itemIndex,
                                    int pageViewIndex,
                                  ) => Container(
                                    child: Image.network(
                                      "${Urls.posterPathBaseUrl}${_trendingList[itemIndex].poster_path}",
                                      fit: BoxFit.fill,
                                      width: double.maxFinite,
                                    ),
                                  ),
                              options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1,
                                height: _screenHeight * 0.5,
                              ),
                            )
                            : Center(child: CircularProgressIndicator()),
                    stretchModes: [StretchMode.zoomBackground],
                  ),
                  centerTitle: true,
                  pinned: true,
                  floating: false,
                  stretch: true,
                  expandedHeight: _screenHeight * 0.5,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(10),
                    child: Column(
                      children: [
                        SizedBox(height: 0.0),
                        TabBar(
                          labelPadding: const EdgeInsets.only(bottom: 10),
                          tabs: [Text("Now Playing"), Text("Popular Movies")],
                          dividerColor: AppColors.deepBlue,
                          indicatorColor: Colors.grey,
                          labelColor: Colors.white,
                          labelStyle: TextStyle(fontWeight: FontWeight.w800),
                          unselectedLabelColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                // SliverList(
                //   delegate: SliverChildListDelegate([
                //     SizedBox(height: 8),
                //     TabBar(
                //       labelPadding: const EdgeInsets.only(bottom: 10),
                //       tabs: [Text("Now Playing"), Text("Popular Movies")],
                //       dividerColor: AppColors.deepBlue,
                //       indicatorColor: Colors.grey,
                //       labelColor: Colors.white,
                //       labelStyle: TextStyle(fontWeight: FontWeight.w800),
                //       unselectedLabelColor: Colors.white,
                //     ),
                //   ]),
                // ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(
                children: [NowPlayingMovieTab(), PopularMoviesTab()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getTrending() async {
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.trendingOfDay,
    );
    if (response.isSuccess) {
      TrendingListModel trendingListModel = TrendingListModel.fromJson(
        response.data ?? {},
      );
      setState(() {
        _trendingList = trendingListModel.trendingList;
      });
    }
  }
}


