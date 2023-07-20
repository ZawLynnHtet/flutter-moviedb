import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../compoment/carousel.dart';
import '../compoment/movie_lists.dart';
import '../data/api.dart';
import '../data/movie_class.dart';
import 'mylist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Result> popular = [];
  List<Result> nowplaying = [];
  List<Result> upcoming = [];
  List<Result> torated = [];
  double scrollOffset = 0.0;
  ScrollController scrollController = ScrollController();

  getTvShows() async {
    popular = await movieApiCall("tv");
    setState(() {});
  }

  getPopularMovies() async {
    popular = await movieApiCall("popular");
    setState(() {});
  }

  getUpcomingMovies() async {
    upcoming = await movieApiCall("upcoming");
    setState(() {});
  }

  getNowplayingMovies() async {
    nowplaying = await movieApiCall("now_playing");
    setState(() {});
  }

  getToratedMovies() async {
    torated = await movieApiCall("top_rated");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularMovies();
    getNowplayingMovies();
    getToratedMovies();
    getUpcomingMovies();
    setState(() {});

    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          scrollOffset = scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.blue
                .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
            elevation: 20,
            leading: Image.asset(
              'images/logo.png',
              scale: 5.0,
            ),
            actions: [
              MaterialButton(
                onPressed: () {},
                child: const Text(
                  "TV Shows",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: const Text(
                  "Moveis",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: const Text(
                  "My List",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: CarouselSliderPage(topRated: torated),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MyList();
                      }));
                    },
                    child: const Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: 25,
                        ),
                        Text(
                          "My List",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.play,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                  MaterialButton(
                    onPressed: () async {},
                    child: const Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.circleInfo,
                          color: Colors.white,
                          size: 25,
                        ),
                        Text(
                          "Info",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 15),
          //     child: Column(
          //       children: [
          //         const Text(
          //           "Watching this movie",
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               fontWeight: FontWeight.w500),
          //         ),
          //         Row(
          //           children: [
          //             SizedBox(
          //               width: 160.0,
          //               child: Column(
          //                 children: [
          //                   SizedBox(
          //                     width: 160.0,
          //                     height: 200.0,
          //                     child: Image.network(
          //                       "https://i.ebayimg.com/images/g/GtEAAOSw1W9eN1cY/s-l1600.jpg",
          //                       fit: BoxFit.fill,
          //                     ),
          //                   ),
          //                   const LinearProgressIndicator(
          //                     value: 50.0,
          //                     color: Colors.red,
          //                   )
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               width: 160.0,
          //               child: Column(
          //                 children: [
          //                   SizedBox(
          //                     width: 160.0,
          //                     height: 200.0,
          //                     child: Image.network(
          //                       "https://i.ebayimg.com/images/g/GtEAAOSw1W9eN1cY/s-l1600.jpg",
          //                       fit: BoxFit.fill,
          //                     ),
          //                   ),
          //                   const LinearProgressIndicator(
          //                     value: 50.0,
          //                     color: Colors.red,
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 170,
          //         child: Builder(
          //           : getData(),
          //           builder: (context, snapshot){
          //             if(snapshot.connectionState == ConnectionState.waiting){
          //               return Container();
          //             }else {
          //               return ListView.builder(
          //                 itemCount: snapshot.data.length,
          //                 itemBuilder: (context, index){
          //                    return SizedBox(
          //                     width: 100,
          //                     height: 100,
          //                     child: Image.network(snapshot.data[index].data['image']),
          //                    );
          //                 });
          //             }
          //         }),
          //       )
          //     ],
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nowplaying Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  MoviesLists(moviesLists: nowplaying),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Popular Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  MoviesLists(moviesLists: popular),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  MoviesLists(moviesLists: upcoming),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Toprated Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  MoviesLists(moviesLists: torated),
                ],
              ),
            ),
          )
        ],
      );
  }
}