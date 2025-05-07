import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tmdbmovies/data/utils/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdbmovies/ui/controllers/home_screen_controller.dart';
import 'package:tmdbmovies/ui/screens/color.dart';
import 'package:tmdbmovies/ui/screens/detail_screen.dart';
import 'package:tmdbmovies/ui/tabs/now_Playing_movie_tab.dart';
import 'package:tmdbmovies/ui/tabs/popular_movies_tab.dart';
import 'package:tmdbmovies/ui/tabs/trending_movies_tab.dart';
import 'package:tmdbmovies/ui/tabs/upcoming_movies_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  final _homeScreenController = Get.find<HomeScreenController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _getTrending();
    // Listen to tab changes
  }


  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return <Widget>[
              GetBuilder<HomeScreenController>(
                builder: (_) {
                  return SliverAppBar(
                    backgroundColor: AppColors.deepBlue,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Trending  🔥",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 12),
                        SizedBox(
                          height: 45,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DropdownButton(
                              value: _homeScreenController.getDropDownValue,
                              dropdownColor: AppColors.deepBlue,
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.amberAccent,
                              ),
                              autofocus: true,
                              items: [
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "Daily",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text(
                                    "Weekly",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                _homeScreenController.setDropDownValue = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background:
                          _homeScreenController.getTrendingList.isNotEmpty
                              ? CarouselSlider.builder(
                                itemCount:
                                    _homeScreenController.getTrendingList.length,
                                itemBuilder:
                                    (
                                      BuildContext context,
                                      int itemIndex,
                                      int pageViewIndex,
                                    ) => InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(index: itemIndex,controller: _homeScreenController,)));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: "${Urls.posterPathBaseUrl}${_homeScreenController.getTrendingList[itemIndex].poster_path}",
                                        fit: BoxFit.fill,
                                        width: double.maxFinite,
                                        //placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                    //     Image.network(
                                    //   "${Urls.posterPathBaseUrl}${_homeScreenController.trendingList[itemIndex].poster_path}",
                                    //   fit: BoxFit.fill,
                                    //   width: double.maxFinite,
                                    // ),
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
                      preferredSize: const Size.fromHeight(-4),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.deepBlue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.arrow_drop_up_rounded,
                                  color: Colors.grey,
                                ),
                                TabBar(
                                  controller: _tabController,
                                  isScrollable: false,
                                  labelPadding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  tabs: [
                                    Text("Now Playing"),
                                    Text("Popular"),
                                    Text("Top Rated"),
                                    Text("Upcoming"),
                                  ],
                                  dividerColor: AppColors.deepBlue,
                                  indicatorColor: Colors.grey,
                                  labelColor: Colors.white,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  unselectedLabelColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
              controller: _tabController,
              physics: ScrollPhysics(),
              children: [
                NowPlayingMovieTab(),
                PopularMoviesTab(),
                TrendingMoviesTab(),
                UpcomingMoviesTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getTrending() async {
    final bool isSuccess = await _homeScreenController.getTrending();
    if (isSuccess) {
    } else {
      Get.snackbar("Error", _homeScreenController.getErrorMag);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
