import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/data/movie_class.dart';

// ignore: must_be_immutable
class CarouselSliderPage extends StatelessWidget {
  CarouselSliderPage({super.key, required this.topRated});

  List<Result> topRated = [];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
                  options: CarouselOptions(
                  autoPlay: true,
                  height: 230,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(microseconds: 800),
                  viewportFraction: 0.8,),
                items: topRated.map((item) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage("http://image.tmdb.org/t/p/w500${item.backdropPath}"),
                    fit: BoxFit.cover)
                  ),
                ))
            .toList(),);
  }
}