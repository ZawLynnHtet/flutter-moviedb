import 'package:flutter/material.dart';
import 'package:movie_app/data/api.dart';

import '../data/movie_class.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Result?> recommend = [];
  List<Result?> searchResult = [];
  bool search = false;
  TextEditingController movieName = TextEditingController();

  searchMovie()async{
    searchResult = await searchApiCall(movieName.text);
    setState(() {
      
    });
  }

  searchRecommend() async {
    recommend = await movieApiCall('now_playing');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    searchMovie();
    searchRecommend();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(31, 28, 1, 36),
      child: GestureDetector(
        onTap: () {
          search = false;
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 20,
            title: TextField(
              controller: movieName,
              onSubmitted: (value) async{
                await searchMovie();
                setState(() {
                  
                });
              },
              onTap: () {
                search = true;
                setState(() {
                  
                });
              },
              cursorColor: Colors.white24,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.white10,
                  filled: true,
                  hintText: "Search Movies",
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(onPressed: ()async{
                    await searchMovie();
                  }, icon: const Icon(Icons.search,
                  color: Colors.white54,
                  size: 26,)),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
          ),
          body: SingleChildScrollView(
            child: search == false? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recommend for you",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recommend.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / 1.3),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: recommend.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    )
                                  : Image.network(
                                      "http://image.tmdb.org/t/p/w500/${recommend[index]!.backdropPath}",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ): searchResult.isEmpty? Container(): Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Result",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 500,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network("http://image.tmdb.org/t/p/w500/${searchResult[0]!.backdropPath}",
                          fit: BoxFit.cover,),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(searchResult[0]!.originalTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),),
                          Text(searchResult[0]!.originalLanguage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),),
                          Text("${searchResult[0]!.popularity} ⭐",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),),
                          Text(searchResult[0]!.overview,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),),
                        ],
                      )
                    ],
                  ),
                  Text(searchResult[0]!.overview,
                  textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),),
                ],
              ),),
          ),
        ),
      ),
    );
  }
}
