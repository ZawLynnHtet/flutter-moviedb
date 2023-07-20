import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/api.dart';
import 'package:movie_app/data/cast.dart';
import 'package:movie_app/data/details_overall.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/data/movie_class.dart';
import 'package:movie_app/provider/favorite.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({super.key, required this.id});
  int id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Details? details;
  bool load = true;

  List<Cast> cast = [];
  List<Result?> recommend = [];
  List<Result?> similar = [];

  // getFavorite() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final favMovie = prefs.getStringList('favorite');
  //   print("-------$favMovie---------");
  //   setState(() {});
  // }

  getDetails() async {
    details = await detailsApiCall(widget.id);
    setState(() {});
  }

  getCast() async {
    cast = await castApiCall(widget.id);
    load = false;
    setState(() {});
  }

  getSimilar() async {
    similar = await similarMovieApiCall(widget.id);
    setState(() {});
  }

  getRecommend() async {
    recommend = await recommendMovieApiCall(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    getDetails();
    getCast();
    getRecommend();
    getSimilar();
    // getFavorite();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 1, 41),
      body: details == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 500.0,
                        child: Stack(alignment: Alignment.topCenter, children: [
                          SizedBox(
                            height: 500.0,
                            child: Image.network(
                              "http://image.tmdb.org/t/p/w500/${details!.backdropPath}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 50, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton.filled(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.chevron_back,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                IconButton.filled(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.gear_solid,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                              ],
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 500.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 60),
                              child: IconButton.filledTonal(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15.0),
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.play_fill,
                                    color: Colors.black,
                                    size: 30,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              const Color.fromARGB(0, 0, 0, 0),
                              const Color.fromARGB(255, 17, 1, 31)
                                  .withOpacity(.90),
                              const Color.fromARGB(255, 22, 1, 41)
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 50, left: 20, right: 20),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                    colors: [Colors.white24, Colors.white24])),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          details!.originalTitle,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              highlightColor: Colors.white24,
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.shareNodes,
                                                color: Colors.white,
                                                size: 20,
                                              )),
                                          IconButton(
                                              highlightColor: Colors.white24,
                                              onPressed: () async {
                                                provider.toggleFavorite(
                                                    details.toString());
                                              },
                                              icon: Icon(
                                                CupertinoIcons.heart_fill,
                                                color: provider.isExist(
                                                        details.toString())
                                                    ? Colors.red
                                                    : Colors.white,
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.blue,
                                        ),
                                        child: Text(
                                          details!.genres[0].name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 90,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              255, 159, 33, 243),
                                        ),
                                        child: Text(
                                          details!.originalLanguage,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              255, 183, 196, 5),
                                        ),
                                        child: Text(
                                          "${details!.popularity} ⭐",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      details!.overview,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  cast.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                "Cast",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 111, 40, 198),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cast.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: load == true
                                              ? const CircularProgressIndicator(
                                                  color: Colors.blue,
                                                )
                                              : Image.network(
                                                  "http://image.tmdb.org/t/p/w500/${cast[index].profilePath}",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      : Container(),
                  recommend.isEmpty
                      ? similar.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Text(
                                    "Similar Movies",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: similar.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                            height: 150,
                                            width: 280,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  "http://image.tmdb.org/t/p/w500/${similar[index]!.backdropPath}",
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            )
                          : Container()
                      : recommend.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Text(
                                    "Recommended for you",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recommend.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                            height: 150,
                                            width: 280,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                "http://image.tmdb.org/t/p/w500/${recommend[index]!.backdropPath}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            )
                          : Container(),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
    );
  }
}
