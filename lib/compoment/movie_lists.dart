import 'package:flutter/material.dart';
import 'package:movie_app/data/movie_class.dart';

import '../pages/details_page.dart';

// ignore: must_be_immutable
class MoviesLists extends StatefulWidget {
  MoviesLists({super.key, required this.moviesLists});

  List<Result> moviesLists = [];

  @override
  State<MoviesLists> createState() => _MoviesListsState();
}

class _MoviesListsState extends State<MoviesLists> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.moviesLists.isEmpty? const CircularProgressIndicator(color: Colors.blue,):
      SizedBox(
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.moviesLists.length,
          itemBuilder: (context, index){
          return SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(id: widget.moviesLists[index].id)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network("http://image.tmdb.org/t/p/w500/${widget.moviesLists[index].backdropPath}",
                  fit: BoxFit.cover,),
                ),
              ),
            ),
          );
        }),
      )
    );
  }
}

