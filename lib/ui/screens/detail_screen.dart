import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdbmovies/ui/screens/color.dart';
import 'package:tmdbmovies/ui/tabs/about_movies_tab.dart';
import 'package:tmdbmovies/ui/tabs/cast_movies_tab.dart';
import 'package:tmdbmovies/ui/tabs/reviews_movies_tab.dart';
import 'package:tmdbmovies/ui/widgets/divider.dart';

import '../../data/utils/urls.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final controller;

  @override
  State<DetailScreen> createState() => _DetailScreenState(index, controller);
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final int index;
  final controller;

  _DetailScreenState(this.index, this.controller);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Listen to tab changes
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      appBar: AppBar(
        backgroundColor: AppColors.deepBlue,
        title: Text("Detail"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.maxFinite,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "${Urls.backdropPathBaseUrl}${controller.getTrendingList[index].backdrop_path}",
                      ),
                      fit: BoxFit.fill
                    ),
                  ),
                  child: buildRatingUi(),
                ),
                Positioned(
                  bottom: -80,
                  left: 10,
                  right: 10,
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width -
                        20, // account for left and right padding
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 120,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.blue,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  "${Urls.posterPathBaseUrl}${controller.getTrendingList[index].poster_path}",
                                ),
                                fit: BoxFit.fill
                            ),
                          ),

                        ),
                        SizedBox(width: 10),
                        Expanded(
                          // use Expanded instead of Flexible inside a Row
                          child: Text(
                            controller.getTrendingList[index].original_title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 2,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
                Text(controller.getTrendingList[index].release_date, style: TextStyle(color: Colors.grey)),
                buildDivider(),
                Icon(Icons.access_time_outlined, color: Colors.grey, size: 16),
                Text("148 minutes", style: TextStyle(color: Colors.grey)),
                buildDivider(),
                Icon(Icons.local_movies_sharp, color: Colors.grey, size: 16),
                Text("Action", style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelPadding: const EdgeInsets.only(bottom: 10),
              tabs: [Text("Overview"), Text("Reviews"), Text("Cast")],
              dividerColor: AppColors.deepBlue,
              indicatorColor: Colors.grey,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.w800),
              unselectedLabelColor: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  controller: _tabController,
                  physics: ScrollPhysics(),
                  children: [
                    SingleChildScrollView(child: AboutMoviesTab(overview: controller.getTrendingList[index].overview,)),
                    SingleChildScrollView(child: ReviewsMoviesTab()),
                    SingleChildScrollView(child: CastMoviesTab()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRatingUi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: 24,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.deepBlue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star_border, size: 16, color: AppColors.halkaOrange),
                Text(
                  controller.getTrendingList[index].vote_avg.toString(),
                  style: TextStyle(fontSize: 14, color: AppColors.halkaOrange),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
